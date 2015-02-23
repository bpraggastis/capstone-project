class MedicalCauseCondition < ActiveRecord::Base



  belongs_to :medical_condition
  belongs_to :medical_cause
  validates :medical_cause, :medical_condition, presence: true
end
