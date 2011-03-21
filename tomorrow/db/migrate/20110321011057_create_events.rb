class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title, :null => false
      t.time :start_time, :null => false
      t.time :end_time, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.string :location
      t.text :description
      t.integer :privacy
      t.boolean :all_day
      t.boolean :repeat, :default => false
      t.string :on_days
      t.string :on_months
      t.string :on_years

      t.integer :email_notif
      t.integer :popup_notif

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
