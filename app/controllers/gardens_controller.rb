class GardensController < ApplicationController
  def index
    @gardens = Garden.all
  end

  def new
    @garden = Garden.new
  end

  def show
    @garden = Garden.find_by(id: params[:id])

    if @garden.nil?
      # Handle the case where the garden is not found
      # For example, you can redirect to a different page or display an error message
    else
      @recommendations = Recommendation.where(garden_id: @garden.id)
    end
  end

  # app/controllers/gardens_controller.rb

  def create
    @garden = Garden.new(garden_params)
    if @garden.save
      redirect_to garden_path(@garden)
    else
      render :new
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:size, :sunlight)
  end

  def fetch_recommendations(size, sunlight, location)
    # Call ChatGPT API to fetch recommendations based on garden details
    # Implement your logic here and return the recommendations
  end
end
