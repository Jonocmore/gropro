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
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end
end
