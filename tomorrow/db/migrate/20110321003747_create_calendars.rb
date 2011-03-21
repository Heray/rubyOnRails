class CreateCalendars < ActiveRecord::Migration
  def self.up
    create_table :calendars do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :privacy
      t.string :location
      t.string :timezone
      t.string :country
      t.integer :email_notif
      t.integer :popup_notif
      t.string :invite_notif
      t.string :change_notif
      t.string :cancel_notif
      t.string :reply_notif


      t.timestamps
    end
  end

  def self.down
    drop_table :calendars
  end
end
