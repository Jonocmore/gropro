class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home show]

  def home
    category = params[:category]

    if params[:query].present?
      @plants = Plant.search_by_plant_name(params[:query])
    else
      @plants = if category.present?
        if category == 'popular'
          Plant.where(popular: true)
        else
          Plant.where(category: category)
        end
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
