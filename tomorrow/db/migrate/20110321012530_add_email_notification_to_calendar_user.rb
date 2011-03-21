class AddEmailNotificationToCalendarUser < ActiveRecord::Migration
  def self.up
    add_column :calendar_users, :email_notif, :integer
    add_column :calendar_users, :popup_notif, :integer
    add_column :calendar_users, :invite_notif, :string
    add_column :calendar_users, :change_notif, :string
    add_column :calendar_users, :cancel_notif, :string
    add_column :calendar_users, :reply_notif, :string

  end

  def self.down
    remove_column :calendar_users, :reply_notif
    remove_column :calendar_users, :cancel_notif
    remove_column :calendar_users, :change_notif
    remove_column :calendar_users, :invite_notif
    remove_column :calendar_users, :popup_notif
    remove_column :calendar_users, :email_notif
  end
end
