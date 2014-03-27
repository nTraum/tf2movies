# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  nickname          :string(255)
#  steam_profile_url :string(255)
#  last_login        :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  last_online       :datetime
#  steam_id          :integer
#  role_cd           :integer
#

class User < ActiveRecord::Base
  as_enum   :role,              :banned => 0, :user => 1, :moderator => 2, :admin => 3
  has_many  :suggestions,       :class_name => 'Movie'
  has_many  :comments
  validates :steam_id,          :presence => true,
                                :uniqueness => true
  validates :nickname,          :presence => true
  validates :steam_profile_url, :presence => true,
                                :uniqueness => true
  validates :role,              :as_enum => true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.nickname = auth['info']['nickname']
      user.steam_id = auth['uid'].to_i
      user.steam_profile_url = auth['info']['urls']['Profile']
      user.user!
      user.last_login = DateTime.current
      user.last_online = DateTime.current
    end
  end

  def refresh_user_info(auth)
    new_nickname = auth['info']['nickname']
    new_steam_profile_url = auth['info']['urls']['Profile']

    if (nickname != new_nickname or steam_profile_url != new_steam_profile_url)
      update_attributes :nickname => new_nickname,
                        :steam_profile_url => new_steam_profile_url
    end
  end

  def refresh_last_online
    update :last_online => DateTime.current
  end

  def online?
    (Time.current - last_online) < 10.minutes
  end

  def staff?
    admin? || moderator?
  end

  def refresh_last_login
    update :last_login => DateTime.current
  end
end
