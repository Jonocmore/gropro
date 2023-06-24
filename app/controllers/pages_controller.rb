class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home show]

  def home
    category = params[:category]
    puts "Category: #{category}" # Add this line for debugging

    if params[:query].present?
      @plants = Plant.search_by_plant_name(params[:query])
    else
      @plants = if category.present?
        Plant.where(category: category)
      else
        Plant.order(:plant_name)
      end
    end

    puts "Plants count: #{@plants}" # Add this line for debugging
  end

  def show
    @plant = Plant.find(params[:id])
  end

  # Other actions in the PagesController
end
