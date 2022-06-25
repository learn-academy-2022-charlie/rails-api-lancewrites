class ChangeColumnDataPrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :sightings, :latitude, :decimal, precision: 10, scale: 6
    change_column :sightings, :longitude, :decimal, precision: 10, scale: 6
  end
end
