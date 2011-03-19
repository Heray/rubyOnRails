class User < ActiveRecord::Base
  has_many :event, :dependent => :destroy
end
