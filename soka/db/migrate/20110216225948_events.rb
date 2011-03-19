class Events < ActiveRecord::Migration
  def self.up
    add_column :users_id, :string
  end

  def self.down
    remove_column :users_id, :string
  end
end
