class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home show]

  def home
    category = params[:category]
    puts "Category: #{category}" # Add this line for debugging

    @plants = if category.present?
        Plant.where(category: category).order("RANDOM()").limit(4)
      else
        Plant.order("RANDOM()").limit(32)
      end

    puts "Plants count: #{@plants}" # Add this line for debugging
  end

  def show
  end

  # Other actions in the PagesController
end
