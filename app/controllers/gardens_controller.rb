class GardensController < ApplicationController
  def index
    @user = current_user
    @gardens = Garden.where(user_id: @user)
    if params[:message]
      @response = ChatgptService.call("What is your name?")
    end
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

  # def get_advice
  #   # Get and validate user input
  #   garden_name = params[:name]
  #   location = params[:location]
  #   outside = params[:outside]
  #   garden_size = params[:size]
  #   sunlight = params[:sunlight]
  #   additional_info = params[:additional_info]

  #   if garden_name.blank? || garden_size.blank?
  #     return render json: { error: "Garden name and garden size are required." }, status: :bad_request
  #   end

  #   # Format the prompt
  #   prompt = "I need advice on how to grow #{garden_name} in a #{garden_size} garden."

  #   # Use the service to get the AI's response
  #   @result = OpenAiService.new(prompt: prompt).call

  #   if result[:error]
  #     render json: { error: @result[:error] }, status: :internal_server_error
  #   else
  #     render json: { advice: @result[:response] }
  #   end
  # end

  private

  def garden_params
    params.require(:garden).permit(:size, :sunlight, :name, :location, :outside, :additional_info)
  end
end
