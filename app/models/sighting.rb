class Sighting < ApplicationRecord
    validates :date, :latitude, :longitude, presence: true
    belongs_to :animal
end
