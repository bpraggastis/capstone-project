class Place < ActiveRecord::Base

  has_many :event_places
  has_many :events, through: :event_places
  
end
