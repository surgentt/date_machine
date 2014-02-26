class Profile < ActiveRecord::Base

  #ensure that the same user isn't getting saved twice
  validates_uniqueness_of :username

end