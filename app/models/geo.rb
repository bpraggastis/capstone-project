class Geo < ActiveRecord::Base
  # these are specific places given by latitude and longitude

  belongs_to :place
  has_many :events

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
