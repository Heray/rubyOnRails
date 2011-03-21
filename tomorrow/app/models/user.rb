class User < ActiveRecord::Base
  has_many :event_users
  has_many :events, :through => :event_users

  has_many :calendar_users
  has_many :calendars, :through => :calendar_users

  #has_many :friends, :foreign_key => "user_id",:dependent => :destroy
end
