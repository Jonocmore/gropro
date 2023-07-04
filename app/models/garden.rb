class Garden < ApplicationRecord
  belongs_to :user
  has_many :garden_plants
  has_many :plants, through: :garden_plants
  has_many :recommendations

  include PgSearch::Model

  pg_search_scope :search_by_plant_name,
    against: [ :plant_name ],
    using: {
      tsearch: { prefix: true }
    }
end
