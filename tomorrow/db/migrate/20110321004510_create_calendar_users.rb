class CreateCalendarUsers < ActiveRecord::Migration
  def self.up
    create_table :calendar_users do |t|

      t.references :user
      t.references :calendar
      t.string :permission

      t.timestamps
    end

    execute "ALTER TABLE calendar_users ADD FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE calendar_users ADD FOREIGN KEY (calendar_id) REFERENCES calendars(id)"




  end

  def self.down
    drop_table :calendar_users
  end
end
