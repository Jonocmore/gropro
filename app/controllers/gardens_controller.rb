class GardensController < ApplicationController
  def index
    @user = current_user
    @gardens = Garden.where(user_id: @user)
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
  def new
    @garden = Garden.new
    @recommendation = Recommendation.new
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    if @garden.save
      redirect_to garden_recommendations_path(@garden)
    else
      render :new
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:size, :percentage)
  end
end
