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




