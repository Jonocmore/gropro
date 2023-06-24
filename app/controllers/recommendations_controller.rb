class RecommendationsController < ApplicationController
  def index
    @garden = Garden.find(params[:garden_id])
    @recommendations = Recommendation.where(garden_id: @garden.id)
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    # Additional code to render the show page
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:size)
  end
end
