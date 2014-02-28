class Profile < ActiveRecord::Base

  validates_uniqueness_of :username
  has_many :messages

end