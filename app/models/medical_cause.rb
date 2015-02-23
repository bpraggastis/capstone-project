class MedicalCause < ActiveRecord::Base

  

  has_many :medical_cause_conditions
  has_many :medical_conditions, through: :medical_cause_conditions
end
