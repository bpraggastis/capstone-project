class Outbreak < ActiveRecord::Base

  belongs_to :event
  belongs_to :medical_condition
end
