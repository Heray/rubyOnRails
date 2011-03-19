class AfEvents < ActiveRecord::Migration
  def self.up
    execute "alter table events add foreign key 'u_id' references users 'id'"
    
  end

  def self.down
  end
end
