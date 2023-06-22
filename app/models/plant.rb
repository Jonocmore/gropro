class Plant < ApplicationRecord
  has_many :garden_plants
  has_many :gardens, through: :plants

  enum category: {
         fruits: "fruits",
         vegetables: "vegetables",
         flowers: "flowers",
         herbs: "herbs",
       }

  # Other model code
end
