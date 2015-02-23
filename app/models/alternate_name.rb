class AlternateName < ActiveRecord::Base

  validates_uniqueness_of :name



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
    return response
  end

end
