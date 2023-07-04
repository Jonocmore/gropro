# app/services/plant_service.rb
class PlantService
  def self.get_plant_name_and_image(id)
    plant = Plant.find(id)
    plant_name = plant.plant_name
    plant_image = plant.plant_image
    # ...
  end
end
