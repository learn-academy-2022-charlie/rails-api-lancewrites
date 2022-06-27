require 'rails_helper'

RSpec.describe Sighting, type: :model do
  describe 'Sighting Model' do
    it 'shows an error if a sighting does not include a date' do
      sigthing_entry = Sighting.create(date: nil, latitude: 45.000001, longitude: 47.000002, animal_id: 1) 
      expect(sigthing_entry.errors[:date]).to_not be_empty
    end
    it 'shows an error if a sighting does not include a latitude' do
      sigthing_entry = Sighting.create(date: '2022-01-28 05:40:30', latitude: nil, longitude: 47.000002, animal_id: 1) 
      expect(sigthing_entry.errors[:latitude]).to_not be_empty
    end
    it 'shows an error if a sighting does not include a longitude' do
      sigthing_entry = Sighting.create(date: '2022-01-28 05:40:30', latitude: 45.000001, longitude: nil, animal_id: 1) 
      expect(sigthing_entry.errors[:longitude]).to_not be_empty
    end
  end
end
