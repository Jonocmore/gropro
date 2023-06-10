require 'faker'

# Users
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    username: Faker::Internet.unique.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# Forums
5.times do
  Forum.create!(
    name: Faker::Lorem.word.capitalize,
    user_id: User.pluck(:id).sample
  )
end

# Plants
10.times do
  Plant.create!(
    name: Faker::Food.vegetables,
    category: ["Vegetable", "Fruit", "Herb", "Flower"].sample,
    description: Faker::Lorem.paragraph,
    water_schedule: ["Daily", "Weekly", "Monthly"].sample,
    location: Faker::Address.city,
    how_to: Faker::Lorem.paragraph,
    sunlight: rand(1..10),
    size: rand(1..10),
    lifecycle: ["Annual", "Perennial", "Biennial"].sample
  )
end

# Gardens
10.times do
  Garden.create!(
    name: Faker::Lorem.word.capitalize,
    user_id: User.pluck(:id).sample,
    date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
    location: Faker::Address.city,
    sunlight: rand(1..10),
    size: rand(1..500),
    outside: [true, false].sample
  )
end

# GardenPlants
30.times do
  GardenPlant.create!(
    garden_id: Garden.pluck(:id).sample,
    plant_id: Plant.pluck(:id).sample,
    user_id: User.pluck(:id).sample,
    comment: Faker::Lorem.sentence,
    planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    expected_harvest_date: Faker::Date.forward(days: 60)
  )
end

# Massages
30.times do
  Massage.create!(
    content: Faker::Lorem.paragraph,
    forum_id: Forum.pluck(:id).sample,
    user_id: User.pluck(:id).sample
  )
end

# Recommendations
30.times do
  Recommendation.create!(
    plant_id: Plant.pluck(:id).sample,
    text: Faker::Lorem.paragraph,
    trigger_conditions: Faker::Lorem.sentence,
    garden_id: Garden.pluck(:id).sample
  )
end

# Resources
10.times do
  Resource.create!(
    title: Faker::Book.title,
    text: Faker::Lorem.paragraph,
    author: Faker::Book.author,
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    type: "pdf",
    url: Faker::Internet.url
  )
end
