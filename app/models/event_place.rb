class EventPlace < ActiveRecord::Base
    
  belongs_to :event
  belongs_to :place

end
