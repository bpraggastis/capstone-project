class AlternateName < ActiveRecord::Base

  include Searchable

  #medical_condition associations
  has_many :synonyms
  has_many :medical_conditions, through: :synonyms

  def self.search(query)
    response = __elasticsearch__.search(
    {
      query: {
        fuzzy_like_this_field: {
          name: {
            like_text: query
          }
        }
      }
    })
  end
  return response
end
