class AddCalendarIdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :calendar_id, :integer

    execute "ALTER TABLE events ADD FOREIGN KEY (calendar_id) REFERENCES calendars(id)"



  end


  def self.down
    remove_column :events, :calendar
  end
end
