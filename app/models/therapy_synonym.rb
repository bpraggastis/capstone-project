class TherapySynonym < ActiveRecord::Base

  include Searchable

  belongs_to :therapy_alternate_name
  belongs_to :medical_therapy
end
