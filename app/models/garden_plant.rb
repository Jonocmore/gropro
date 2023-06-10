class GardenPlant < ApplicationRecord
  belongs_to :garden
  belongs_to :plant
  belongs_to :user
end
