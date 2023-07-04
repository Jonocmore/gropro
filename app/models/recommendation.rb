class Recommendation < ApplicationRecord
  belongs_to :garden
  attribute :sunlight, :decimal
  belongs_to :plant
  validates :plant_name, presence: true
  validates :plant_image, presence: true

  # def self.create_from_garden(garden)
  #   # Generate recommendations based on garden parameters
  #   # You can implement your own logic here
  #   recommendations = generate_recommendations(garden)

  #   # Create a new recommendation associated with the garden
  #   recommendation = garden.recommendations.build
  #   recommendation.plants = recommendations
  #   recommendation.save
  # end

  # private

  # def self.generate_recommendations(garden)
  #   # Implement your logic to generate recommendations based on the garden's parameters
  #   # This could involve querying the Plant model based on garden parameters
  #   # and returning a collection of recommended plants

  #   # Example: Return the first 10 plants in the database as recommendations
  #   Plant.limit(10)
  # end
end
