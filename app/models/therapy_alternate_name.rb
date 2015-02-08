class TherapyAlternateName < ActiveRecord::Base

  has_many :therapy_synonyms
  has_many :medical_therapies, through: :therapy_synonyms

end
