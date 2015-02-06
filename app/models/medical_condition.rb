class MedicalCondition < ActiveRecord::Base

  include Searchable

  #join tables for medical therapies
  has_many :primary_preventions
  has_many :possible_treatments

  #medical therapy associations
  has_many :treaments, source: :medical_therapy, through: :possible_treatments
  has_many :preventions, source: :medical_therapy, through: :primary_preventions

  #medical code associations
  has_many :medical_code_conditions
  has_many :codes, source: :medical_code, through: :medical_code_conditions

  #medical cause associations
  has_many :medical_cause_conditions
  has_many :causes, source: :medical_cause, through: :medical_cause_conditions

  #alternate name associations
  has_many :synonyms
  has_many :alternate_names, through: :synonyms

  #outbreak associations
  has_many :outbreaks
  has_many :events, through: :outbreaks


  def self.search(query)
    response = __elasticsearch__.search(
    {
      query: {
        fuzzy_like_this_field: {
          name: {
            like_text: query
          }
        }
      },
      highlight: {
        pre_tags: ['<span class="hi-lite">'],
        post_tags: ['</span>'],
        fields: {
          name: {}
        }
      }
    })

  end






end
