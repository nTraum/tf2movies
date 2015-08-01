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
  include PgSearch

  TIMESPAN_UNTIL_OFFLINE  = 10.minutes
  ONLINE_REFRESH_INTERVAL = 5.minutes

  pg_search_scope :search,            against: { nickname: "A", steam_id: "C", steam_profile_url: "D" },
                                      using: { tsearch: { prefix: true } }

  as_enum :role,              banned: 0, user: 1, moderator: 2, admin: 3
  has_many :suggestions,       class_name: "Movie"
  has_many :comments
  has_and_belongs_to_many :movies
  validates :steam_id,          presence: true,
                                uniqueness: true
  validates :nickname,          presence: true
  validates :steam_profile_url, presence: true,
                                uniqueness: true
  validates :role,              presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.nickname = auth["info"]["nickname"]
      user.steam_id = auth["uid"].to_i
      user.steam_profile_url = auth["info"]["urls"]["Profile"]
      user.user!
      user.last_login = Time.zone.now
      user.last_online = Time.zone.now
    end
  end

  def refresh_user_info(auth)
    new_nickname = auth["info"]["nickname"]
    new_steam_profile_url = auth["info"]["urls"]["Profile"]

    if nickname != new_nickname || steam_profile_url != new_steam_profile_url
      update_attributes nickname: new_nickname,
                        steam_profile_url: new_steam_profile_url
    end
  end

  def refresh_last_online
    update(last_online: Time.zone.now) if (last_online < ONLINE_REFRESH_INTERVAL.ago)
  end

  def refresh_last_login
    update(last_login: Time.zone.now)
  end

  def online?
    (Time.zone.now - last_online) < TIMESPAN_UNTIL_OFFLINE
  end

  def staff?
    admin? || moderator?
  end
end
