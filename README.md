# WILDLIFE TRACKER CHALLENGE
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go-ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

## Tasks
### Branch animal-model begin
1. Story: As a developer I can create an animal model in the database. An animal has the following information: common name, latin name, kingdom (mammal, insect, etc.)
```
$ rails generate resource Animal common_name:string latin_name:string kingdom:string
```
2. Story: As the consumer of the API I can see all the animals in the database.
Hint: Make a few animals using Rails Console
> File path: app/controllers/animals_controller.rb
```ruby
    def show
        animal = Animal.find(params[:id])
        render json: animal        
    end
```
3. Story: As the consumer of the API I can update an animal in the database.
> File path: app/controllers/animals_controller.rb
```ruby
    def update
        animal = Animal.find(params[:id])
        if animal.update(animal_params)
            render json: animal
        else
            render json: animal.errors
        end
    end
```
4. Story: As the consumer of the API I can destroy an animal in the database.
> File path: app/controllers/animals_controller.rb
```ruby
    def destroy
        animal = Animal.find(params[:id])
        animals = Animal.all
        animal.destroy
        render json: animals
    end
```
5. Story: As the consumer of the API I can create a new animal in the database.
```ruby
    def create
        animal = Animal.create(animal_params)
        if animal.valid?
            render json: animal           
        else
            render json: animal.errors
        end
    end
```
### Branch animal-model end

### Branch sighting-model begin
6. Story: As the consumer of the API I can create a sighting of an animal with date (use the datetime datatype), a latitude, and a longitude.

```
$ rails g resource Sighting date:datetime latitude:decimal longitude:decimal animal_id:integer
```
>File path: app/models/animal.rb
```ruby
class Animal < ApplicationRecord
    has_many :sightings
end
```
>File path: app/models/sigthing.rb
```ruby
class Sighting < ApplicationRecord
    belongs_to :animal
end
```
7. Story: As the consumer of the API I can update an animal sighting in the database.
>File path: app/controllers/sightings_contoller.rb
```ruby
    def update
        sighting = Sighting.find(params[:id])
        if sighting.update(sighting_params)
            render json: sighting
        else
            render json: sighting.errors
        end
    end
```

8. Story: As the consumer of the API I can destroy an animal sighting in the database.
>File path: app/controllers/sightings_contoller.rb
```ruby
    def destroy
        sighting = Sighting.find(params[:id])
        sightings = Sighting.all
        sighting.destroy
        render json: sightings
```
9. Story: As the consumer of the API, when I view a specific animal, I can also see a list sightings of that animal.
>File path: app/controllers/animals_contoller.rb
```ruby
    def show
        animal = Animal.find(params[:id])      
        render json: animal.as_json(include: :sightings)  #this
    end
```
10. Story: As the consumer of the API, I want to see validation errors if a sighting doesn't include: latitude, longitude, or a date.
>File path: spec/models/sighting_spec.rb
```ruby
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
```
>File path: app/models/sighting.rb
```ruby
class Sighting < ApplicationRecord
    validates :date, :latitude, :longitude, presence: true
    belongs_to :animal
end
```


11. Story: As the consumer of the API, I want to see validation errors if an animal doesn't include a common name, or a latin name.
12. Story: As the consumer of the API, I want to see a validation error if the animals latin name matches exactly the common name.
13. Story: As the consumer of the API, I want to see a validation error if the animals latin name or common name are not unique.
14. Story: As the consumer, I want to see a status code of 422 when a post request can not be completed because of validation errors.

>File path: spec/models/animal_spec.rb
```ruby
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
```
>File path: app/models/animal.rb
```ruby
class Animal < ApplicationRecord
    validates :common_name, :latin_name, presence: true
    validates :common_name, comparison: { other_than: :latin_name }
    validates :common_name, uniqueness: { case_sensitive: false}
    validates :latin_name, uniqueness: { case_sensitive: false}
    has_many :sightings
end
```


