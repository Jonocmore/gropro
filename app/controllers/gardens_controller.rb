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
      prompt = "I have an #{params[:garden][:outside].downcase} garden at #{params[:garden][:location].downcase}, its size is #{params[:garden][:size]} m2 with sunlight exposure of #{params[:garden][:sunlight]} percent. What plants do you recommend based on these factors? Give a list. Reply with only the basic names of plants separated by commas. No other text in the response please. give only a number of plants based on the size of the garden (1m 5 plants, 2m 10 plants etc). you can choose the most relevant plants from this list: Beans (French),
      Agastache,
      Allium (Ornamental),
      Alyssum,
      Amaranthus (Ornamental),
      Apple (Dwarf),
      Apple (Large),
      Apricot (Large),
      Artichoke (Globe),
      Bay,
      Artichoke (Jerusalem),
      Asparagus,
      Aubergine,
      Beans (Broad),
      Aster (China),
      Beans (Dry),
      Blackberry,
      Blackcurrant,
      Beans (Runner),
      Endive,
      Begonia,
      Bells of Ireland,
      Bluebell,
      Buckwheat,
      Blueberry,
      Broccoli,
      Brussels Sprouts,
      Cabbage,
      Catnip,
      Cabbage (Autumn Red),
      Cabbage (Autumn),
      Cabbage (Chinese),
      Cabbage (Red),
      Cabbage (Spring Red),
      Cabbage (Spring),
      Carrot,
      Cherry (Fan),
      Celeriac,
      Celery,
      Celosia,
      Chestnut (Sweet),
      Fruit Tree,
      Chicory,
      Cineraria,
      Cleome,
      Chilli Pepper,
      Coriander,
      Marjoram,
      Corn salad,
      Colchicum,
      Coleus,
      Convolvulus,
      Coreopsis,
      Cornflower,
      Courgette,
      Cowpeas,
      Cucumber,
      Marrow,
      Crimson Clover,
      Crocus,
      Cuphea,
      Daffodil,
      Dianthus,
      Echinacea,
      Daylily,
      Fenugreek,
      Fig (Container Grown),
      Fruit Bush,
      Fennel,
      Flax,
      Feverfew,
      Garlic,
      Ginger,
      Gaillardia,
      Gazania,
      Geranium,
      Gladiolus,
      Hairy Vetch,
      Grape Vine,
      Hazel,
      Mangetout,
      Gypsophila,
      Heliotrope,
      Hops,
      Jostaberry,
      Impatiens,
      Iris,
      Kiwi,
      Lemon,
      Kohlrabi,
      Leek,
      Larkspur,
      Lemon grass,
      Lemon Verbena,
      Lettuce (Headed),
      Lettuce (Lambs),
      Lettuce (Loose Leaf),
      Marigold,
      Lime,
      Lime (Container Grown),
      Loganberry,
      Lobelia,
      Melon,
      Nectarine (Large),
      Mizuna,
      Mustard,
      Nasturtium,
      Nectarine (Dwarf),
      Oats,
      Okra,
      Onion,
      Onion (Autumn planted),
      Onion (Red),
      Nicotiana,
      Pak choy,
      Parsnip,
      Pansy,
      Parsley,
      Peach (Large),
      Pear (Cordon),
      Pear (Dwarf),
      Pear (Espalier),
      Pomegranate,
      Pecan,
      Persimmon,
      Peas,
      Pepper,
      Rhubarb,
      Petunia,
      Phacelia,
      Plum (Fan),
      Plum (Large),
      Phlox (Annual),
      Pincushion Plant,
      Poached Egg Plant,
      Potatoes (Early),
      Potatoes (Maincrop),
      Pumpkin,
      Purslane,
      Radish,
      Portulaca,
      Rye (Annual),
      Rye (Cereal),
      Rosemary,
      Sage,
      Rock Melon,
      Rutabaga,
      Sorrel,
      Salpiglossis,
      Salvia,
      Scarlet Sage,
      Scilla,
      Snapdragon,
      Snowdrop,
      Spinach,
      Spinach (New Zealand),
      Spinach (Perpetual),
      Spring Onion,
      Squash (Summer),
      Squash (Winter),
      Tat soi,
      Stock,
      Strawberry,
      Sweet Potato,
      Sweetcorn,
      Swiss Chard,
      Strawflower,
      Sunflower,
      Sweet Pea,
      Tansy,
      Tree (Large),
      Tree (Small),
      Tomato (Regular),
      Tomato (Cherry),
      Turnip,
      Tulip,
      Valerian,
      Wheat,
      African Wormwood,
      Walnut,
      White currant,
      Viola,
      Zinnia,
      Basil,
      Chives,
      Chives (Garlic),
      Comfrey,
      Dill,
      Fennel (Herb),
      Borage,
      Chamomile,
      Herb,
      Horseradish,
      Lemon Balm,
      Lovage,
      Mint,
      Oregano,
      Stevia,
      Tarragon,
      Thyme,
      Almond,
      Apple (Espalier),
      Apricot (Dwarf),
      Yarrow,
      Cherry (Dwarf),
      Cherry (Semi-Dwarf),
      Cranberry,
      Fig,
      Gooseberry,
      Honeyberry,
      Lemon (Container Grown),
      Orange (Container Grown),
      Peach (Dwarf),
      Pear (Large),
      Plum (Dwarf),
      Raspberry,
      Redcurrant,
      Amaranth (Grain),
      Beetroot,
      Broccoli (Purple Sprouting),
      Cauliflower,
      Cress,
      Kale,
      Quinoa,
      Rocket,
      Salsify,
      Shallots,
      Soya beans,
      Anemone,
      Bergamot,
      Calendula,
      Cosmos,
      Dahlia,
      Grape Hyacinth,
      Hyacinth,
      Lavatera,
      Lavender,
      Lily,
      Nigella,
      Osteospermum,
      Verbena (Annual),
      Apple (Cordon),
      Orange,
      Rose"
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
          recommended_plants.each do |plant_name|
            plant = Plant.find_by(plant_name: plant_name)
            if plant.nil?
              missing_plants << plant_name
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
    @garden = Garden.find(params[:id])
    @plants = Plant.search(params[:query]) if params[:query].present?
    @recommendations = @garden.recommendations
    @valid_plants = @recommendations.map { |recommendation| recommendation.plant.plant_name }
    @recommendation = Recommendation.new
    # raise
    if params[:plant_id].present?
      @selected_plant = Plant.find(params[:plant_id])
      @recommendation.plant_id = @selected_plant.id
    end

    # Percy
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

  def garden_params
    params.require(:garden).permit(:size, :sunlight, :name, :location, :outside, :additional_info)
  end

  def valid_plants
    @garden.recommendations.pluck(:plant_name)
  end

  def parse_ai_response(response)
    response.split(", ")
  end

  # Percy
  def set_garden
    @garden = Garden.find(params[:id])
    @valid_plants = @garden.recommendations.map(&:plant)
  end

  def recommendation_params
    params.require(:recommendation).permit(:plant_name, :plant_image)
    params.require(:recommendation).permit(:plant)
  end
end
