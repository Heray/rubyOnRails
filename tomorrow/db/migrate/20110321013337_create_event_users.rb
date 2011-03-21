class CreateEventUsers < ActiveRecord::Migration
  def self.up
    create_table :event_users do |t|
      t.references :user
      t.references :event
      t.string :permission
      t.integer :email_notif
      t.integer :popup_notif

      t.timestamps
    end

    execute "ALTER TABLE event_users ADD FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE event_users ADD FOREIGN KEY (event_id) REFERENCES events(id)"

  end

  def self.down
    drop_table :event_users
  end
end
