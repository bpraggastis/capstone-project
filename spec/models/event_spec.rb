require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe 'latitude' do
    it 'returns the latitude of the associated geo' do
      e = Event.create()
      g = Geo.create(latitude: 234.234)
      e.geo = g
      expect(e.latitude).to eq(g.latitude)
    end
  end

  describe 'longitude' do
    it 'returns the longitude of the associated geo' do
      e = Event.create()
      g = Geo.create(longitude: 234.234)
      e.geo = g
      expect(e.longitude).to eq(g.longitude)
    end
  end

  describe 'location' do
    it 'returns the name of the associated geo' do
      e = Event.create()
      g = Geo.create(name: "Dillon")
      e.geo = g
      expect(e.location).to eq(g.name)
    end
  end

  describe 'state' do
    it 'returns the state abbreviation of the place from the associated geo' do
      e = Event.create()
      g = Geo.create()
      pl = Place.create(abbreviation: "MN")
      g.place = pl
      e.geo = g
      expect(e.state).to eq(pl.abbreviation)
    end
  end

  describe 'disease' do
    it 'returns the name of the associated medical condition' do
      e = Event.create()
      mc = MedicalCondition.create(name: "Hypochondria")
      e.medical_condition = mc
      expect(e.disease).to eq(mc.name)
    end
  end
end
