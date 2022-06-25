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




