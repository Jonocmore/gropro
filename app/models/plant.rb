class Plant < ApplicationRecord
  has_many :garden_plants
  has_many :gardens, through: :plants
  has_many :recommendations

  include PgSearch::Model

  pg_search_scope :search_by_plant_name,
    against: [ :plant_name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
