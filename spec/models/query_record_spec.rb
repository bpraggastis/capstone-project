require 'rails_helper'

RSpec.describe QueryRecord, :type => :model do
  describe 'parsed_date' do
    it 'returns the start date of a record in the calendar format when passed "start"' do
      qr = QueryRecord.create(start_date: Date.parse("January 1, 2012"))
      result = qr.parsed_date "start"
      expect(result).to eq("Jan+1%2C+2012")
    end
    it 'returns the end date of a record in the calendar format when passed "end"' do
      qr = QueryRecord.create(end_date: Date.parse("March 1, 2013"))
      result = qr.parsed_date "end"
      expect(result).to eq("Mar+1%2C+2013")
    end
  end
end
