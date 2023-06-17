class PlantsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @plant = Plant.find(params[:id])
  end

  def edit
  end

  def update
  end

  def delete
  end
end
