class CreateSightings < ActiveRecord::Migration[7.0]
  def change
    create_table :sightings do |t|
      t.datetime :date
      t.decimal :latitude
      t.decimal :longitude
      t.integer :animal_id

      t.timestamps
    end
  end
end
