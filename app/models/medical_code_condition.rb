class MedicalCodeCondition < ActiveRecord::Base

  

  belongs_to :medical_condition
  belongs_to :medical_code

end
