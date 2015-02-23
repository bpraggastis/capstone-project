class TherapySynonym < ActiveRecord::Base

  

  belongs_to :therapy_alternate_name
  belongs_to :medical_therapy
end
