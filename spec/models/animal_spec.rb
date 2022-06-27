require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'Animal Model' do
    it 'shows an error if an animal does not include a common name' do
      animal_entry = Animal.create(common_name: nil, latin_name: 'lorem ipsum', kingdom: 'mammalia') 
      expect(animal_entry.errors[:common_name]).to_not be_empty
    end

    it 'shows an error if an animal does not include a common name' do
      animal_entry = Animal.create(common_name: 'black deer', latin_name: nil, kingdom: 'mammalia') 
      expect(animal_entry.errors[:latin_name]).to_not be_empty
    end

    it 'shows an error if an animal common name and latin name are the same' do
      animal_entry = Animal.create(common_name: 'black chicken', latin_name: 'black chicken', kingdom: 'mammalia') 
      if animal_entry.common_name == animal_entry.latin_name
        expect(animal_entry.errors).to_not be_empty
      end
    end

    it 'shows an error if an animal does not have a unique common name' do
      Animal.create(common_name: 'purple deer', latin_name:'purplus deerus', kingdom: 'mammalia')
      animal_entry = Animal.create(common_name: 'Purple deer', latin_name: 'deerus purplus', kingdom: 'mammalia') 
      expect(animal_entry.errors[:common_name]).to_not be_empty
    end

    it 'shows an error if an animal does not have a unique latin name' do
      Animal.create(common_name: 'purple chicken', latin_name:'purplus chickenus', kingdom: 'mammalia')
      animal_entry = Animal.create(common_name: 'Purple dog', latin_name: 'Purplus chickenus', kingdom: 'mammalia') 
      expect(animal_entry.errors[:latin_name]).to_not be_empty
    end

  end
end
