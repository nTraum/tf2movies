class RoleAsEnumToUser < ActiveRecord::Migration
  def change
    rename_column :users, :role, :old_role
    add_column    :users, :role_cd, :integer

    User.where(:role_cd => nil).each do |user_without_new_role|
      if 'admin' == user_without_new_role.old_role
        user_without_new_role.admin!
      elsif 'moderator' == user_without_new_role.old_role
        user_without_new_role.moderator!
      elsif 'user' == user_without_new_role.old_role
        user_without_new_role.user!
      elsif 'banned' == user_without_new_role.old_role
        user_without_new_role.banned!
      else
        raise 'something is wrong'
      end
      user_without_new_role.save!
    end

    remove_column :users, :old_role
  end
end
