class PlantsController < ApplicationController
  before_action :set_plant, only: [:show]

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    # plant = Plant.find(params[:id])
    # @plant_name = plant.plant_name
    # @plant_image = plant.plant_image
    # @plant_name, @plant_image = PlantService.get_plant_name_and_image(params[:id])
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end
end
