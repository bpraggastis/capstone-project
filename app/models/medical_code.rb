class MedicalCode < ActiveRecord::Base

  
  has_one :medical_code_therapy
  has_many :medical_code_conditions

  has_one :medical_therapies, through: :medical_code_therapies
  has_many :medical_conditions, through: :medical_code_conditions
  validates_uniqueness_of :code_value, scope: :code_system
end
