class GardensController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @gardens = Garden.where(user_id: @user.id)
  end

  def new
    @garden = Garden.new
  end

  def add_plant
    @garden = Garden.find(params[:id])
    @plant = Plant.find(params[:plant_id])
    @garden.plants << @plant

    redirect_to garden_path(@garden), notice: "Plant added to garden!"
  end

  def remove_plant_from_garden
    @garden = Garden.find(params[:id])
    @plant = Plant.find(params[:plant_id])
    @garden.plants.delete(@plant) # Remove the plant from the garden
    redirect_to garden_path(@garden), notice: "Plant removed from garden successfully."
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    if @garden.save
      prompt = "I have an #{params[:garden][:outside].downcase} garden at #{params[:garden][:location].downcase}, its size is #{params[:garden][:size]} m2 with sunlight exposure of #{params[:garden][:sunlight]} percent. What plants do you recommend based on these factors? Give a list. Reply with only the basic names of plants separated by commas. No other text in the response please. give only a number of plants based on the size of the garden (1m 5 plants, 2m 10 plants, etc.). you can choose the most relevant plants from this list: #{recommended_plants_list}but always include Rose"
      puts "Prompt: #{prompt}"
      ai_response = OpenAiService.new(prompt).call

      if ai_response.nil?
        flash[:error] = "Unexpected error: AI response is nil"
      else
        puts "AI Response: #{ai_response.inspect}" # Debug output

        if ai_response.is_a?(Array)
          recommended_plants = ai_response
        elsif ai_response.key?("choices")
          recommended_plants = parse_ai_response(ai_response["choices"][0]["message"]["content"])
        else
          flash[:error] = "Unexpected error: Invalid AI response format"
        end

        if flash[:error].nil?
          puts "Recommended plants: #{recommended_plants.inspect}" # Debug output

          missing_plants = []
          recommended_plants.each do |plant|
            plant = Plant.find_by(plant: plant)
            if plant.nil?
              missing_plants << plant
            else
              recommendation = Recommendation.create(garden: @garden, plant: plant)
              if recommendation.persisted?
                puts "Successfully created Recommendation with id #{recommendation.id}"
              else
                puts "Failed to create Recommendation: #{recommendation.errors.full_messages.join(", ")}"
              end
            end
          end

          flash[:alert] = "Could not find the following recommended plants in the database: #{missing_plants.join(", ")}" unless missing_plants.empty?
        end
      end

      redirect_to @garden
    else
      render :new
    end
  end

  def show
    category = params[:category]
    puts "Category: #{category}" # Add this line for debugging

    if params[:query].present?
      @plants = Plant.search_by_plant_name(params[:query])
    else
      if category.present?
        if category == "recommended"
          @plants = Plant.where(recommended: true)
          @valid_plants = @garden.plants.where(recommended: true)
        else
          @plants = Plant.where(category: category)
          @valid_plants = @garden.plants.where(category: category)
        end
      else
        @plants = Plant.order(:plant_name)
        @valid_plants = @garden.plants
      end
    end

    puts "Plants count: #{@plants.count}" # Add this line for debugging
    @recommendations = @garden.recommendations
  end

  def edit
  end

  def update
    if @garden.update(garden_params)
      redirect_to garden_path(@garden), notice: "Garden updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @garden = Garden.find(params[:id])
    @garden.destroy
    redirect_to gardens_path, notice: "Garden deleted successfully."
  end

  private

  def set_garden
    @garden = Garden.find(params[:id])
    @valid_plants = @garden.recommendations.map(&:plant)
  end

  def garden_params
    params.require(:garden).permit(:size, :sunlight, :name, :location, :outside, :additional_info)
  end

  def recommended_plants_list
    # List of recommended plants as a string
    <<~PLANTS
      Beans (French),
      Agastache,
      Allium (Ornamental),
      ...
      ...
      Rose
    PLANTS
  end

  def recommendation_params
    params.require(:recommendation).permit(:plant_name, :plant_image)
    params.require(:recommendation).permit(:plant)
  end

  def parse_ai_response(response)
    response.split(", ")
  end
end
