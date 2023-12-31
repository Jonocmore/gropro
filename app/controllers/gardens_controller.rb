class GardensController < ApplicationController

  def index
    @user = current_user
    @gardens = Garden.where(user_id: @user.id)
  end

  def new
    @garden = Garden.new
  end

  def edit
    @garden = Garden.find(params[:id])
  end

  def update
    @garden = Garden.find(params[:id])

    if @garden.update(garden_params)
      redirect_to gardens_path, notice: "Garden successfully updated."
    else
      render :edit
    end
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    if @garden.save
      prompt = "I have a #{params[:garden][:outside].downcase} garden located in #{params[:garden][:location].downcase}. The size of the garden is #{params[:garden][:size]} meters square and it receives #{params[:garden][:sunlight]} percent of sunlight exposure daily. #{params[:garden][:additional_info]}. I'm interested in a list of plant recommendations that would best suit these conditions. The list should be a basic, comma-separated list of plant names only, no extra details needed. The number of plants recommended should correspond to the size of the garden, at a rate of 5 plants per square meter. Please select the most suitable plants from the following list: Beans (French), Agastache, Allium (Ornamental), Alyssum, Amaranthus (Ornamental), Apple (Dwarf), Apple (Large), Apricot (Large), Artichoke (Globe), Bay, Artichoke (Jerusalem), Asparagus, Aubergine, Beans (Broad), Aster (China), Beans (Dry), Blackberry, Blackcurrant, Beans (Runner), Endive, Begonia, Bells of Ireland, Bluebell, Buckwheat, Blueberry, Broccoli, Brussels Sprouts, Cabbage, Catnip, Cabbage (Autumn Red), Cabbage (Autumn), Cabbage (Chinese), Cabbage (Red), Cabbage (Spring Red), Cabbage (Spring), Carrot, Cherry (Fan), Celeriac, Celery, Celosia, Chestnut (Sweet), Fruit Tree, Chicory, Cineraria, Cleome, Chilli Pepper, Coriander, Marjoram, Corn salad, Colchicum, Coleus, Convolvulus, Coreopsis, Cornflower, Courgette, Cowpeas, Cucumber, Marrow, Crimson Clover, Crocus, Cuphea, Daffodil, Dianthus, Echinacea, Daylily, Fenugreek, Fig (Container Grown), Fruit Bush, Fennel, Flax, Feverfew, Garlic, Ginger, Gaillardia, Gazania, Geranium, Gladiolus, Hairy Vetch, Grape Vine, Hazel, Mangetout, Gypsophila, Heliotrope, Hops, Jostaberry, Impatiens, Iris, Kiwi, Lemon, Kohlrabi, Leek, Larkspur, Lemon grass, Lemon Verbena, Lettuce (Headed), Lettuce (Lambs), Lettuce (Loose Leaf), Marigold, Lime, Lime (Container Grown), Loganberry, Lobelia, Melon, Nectarine (Large), Mizuna, Mustard, Nasturtium, Nectarine (Dwarf), Oats, Okra, Onion, Onion (Autumn planted), Onion (Red), Nicotiana, Pak choy, Parsnip, Pansy, Parsley, Peach (Large), Pear (Cordon), Pear (Dwarf), Pear (Espalier), Pomegranate, Pecan, Persimmon, Peas, Pepper, Rhubarb, Petunia, Phacelia, Plum (Fan), Plum (Large), Phlox (Annual), Pincushion Plant, Poached Egg Plant, Potatoes (Early), Potatoes (Maincrop), Pumpkin, Purslane, Radish, Portulaca, Rye (Annual), Rye (Cereal), Rosemary, Sage, Rock Melon, Rutabaga, Sorrel, Salpiglossis, Salvia, Scarlet Sage, Scilla, Snapdragon, Snowdrop, Spinach, Spinach (New Zealand), Spinach (Perpetual), Spring Onion, Squash (Summer), Squash (Winter), Tat soi, Stock, Strawberry, Sweet Potato, Sweetcorn, Swiss Chard, Strawflower, Sunflower, Sweet Pea, Tansy, Tree (Large), Tree (Small), Tomato (Regular), Tomato (Cherry), Turnip, Tulip, Valerian, Wheat, African Wormwood, Walnut, White currant, Viola, Zinnia, Basil, Chives, Chives (Garlic), Comfrey, Dill, Fennel (Herb), Borage, Chamomile, Herb, Horseradish, Lemon Balm, Lovage, Mint, Oregano, Stevia, Tarragon, Thyme, Almond, Apple (Espalier), Apricot (Dwarf), Yarrow, Cherry (Dwarf), Cherry (Semi-Dwarf), Cranberry, Fig, Gooseberry, Honeyberry, Lemon (Container Grown), Orange (Container Grown), Peach (Dwarf), Pear (Large), Plum (Dwarf), Raspberry, Redcurrant, Amaranth (Grain), Beetroot, Broccoli (Purple Sprouting), Cauliflower, Cress, Kale, Quinoa, Rocket, Salsify, Shallots, Soya beans, Anemone, Bergamot, Calendula, Cosmos, Dahlia, Grape Hyacinth, Hyacinth, Lavatera, Lavender, Lily, Nigella, Osteospermum, Verbena (Annual), Apple (Cordon), Orange, Rose."
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
    @garden_plants = @garden.plants
    @recommendations = @garden.recommendations
    @valid_plants = @recommendations.map { |recommendation| recommendation.plant.plant_name }
    @recommendation = Recommendation.new
    if params[:plant_id].present?
      @selected_plant = Plant.find(params[:plant_id])
      @recommendation.plant_id = @selected_plant.id
    end
    category = params[:category]

    if params[:query].present?
      @plants = Plant.search_by_plant_name(params[:query])
    else
      @plants = if category.present?
        if category == 'popular'
          Plant.where(popular: true)
        elsif category == 'recommended'
          Plant.where(plant_name: @valid_plants)
        else
          Plant.where(category: category)
        end
      else
        Plant.order(:plant_name)
      end
    end
    if params[:prompt].present?
      prompt = params[:prompt]
      open_ai_service = OpenAiService.new(prompt)
      @response = open_ai_service.call
    end
    @plants_for_dropdown = @garden_plants.pluck(:plant_name)
    if params[:plant_name].present? && params[:issue].present?
      plant_name = params[:plant_name]
      issue = params[:issue]
      doctor_prompt = "I'm currently facing a problem with my #{plant_name} plant. The specific issue is #{issue}. Could you provide expert advice on the most effective remedy? Please consider the specific characteristics of the #{plant_name} plant and the nature of the #{issue} while providing your recommendations."
      open_ai_service = OpenAiService.new(doctor_prompt)
      @response = open_ai_service.call
    end
  end

  def add_plant
    @garden = Garden.find(params[:id])
    @plant = Plant.find(params[:plant_id])
    @garden.plants << @plant

    if @garden.save
      redirect_to @garden, notice: 'Plant added to garden successfully!'
    else
      redirect_to @garden, alert: 'Failed to add plant to garden.'
    end
  end

  def add_to_garden
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.find(params[:plant_id])

    unless @garden.plants.include?(@plant)
      @garden.garden_plants.create(plant: @plant, user: current_user) # <- Creating the GardenPlant association here
      flash[:success] = "Plant added to garden"
    else
      flash[:error] = "This plant is already in your garden"
    end

    redirect_to garden_path(@garden)
  end

  def remove_from_garden
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.find(params[:plant_id])

    if @garden.plants.include?(@plant)
      @garden.garden_plants.find_by(plant_id: @plant.id).destroy
      flash[:success] = "Plant removed from garden"
    else
      flash[:error] = "This plant is not in your garden"
    end

    redirect_to garden_path(@garden)
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
end
