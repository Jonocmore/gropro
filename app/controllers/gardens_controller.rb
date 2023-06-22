class GardensController < ApplicationController
  def index
    @gardens = Garden.all
  end

  def new
    @garden = Garden.new
  end

  def show
    @garden = Garden.find(params[:id])
    @recommendations = Recommendation.where(garden_id: @garden.id)
  end

  def create
    @garden = Garden.new(garden_params)

    if @garden.save
      @recommendations = fetch_recommendations(@garden.size, @garden.sunlight, @garden.location)
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
