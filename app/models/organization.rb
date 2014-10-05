class Organization < ActiveRecord::Base
  scaffold:Organization
  
  has_and_belongs_to_many :users

end
