class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :user_id, :null => false
      t.integer :friend_id, :null => true
      t.string :friend_email
      t.float :relation
      t.integer :shared_calendars
      t.integer :shared_events

      t.timestamps
    end

    execute "ALTER TABLE friends ADD FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE friends ADD FOREIGN KEY (friend_id) REFERENCES users(id)"

  end

  def self.down
    drop_table :friends
  end
end
