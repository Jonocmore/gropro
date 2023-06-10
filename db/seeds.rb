require 'faker'

# Users
users = 10.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    username: Faker::Internet.unique.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# Forums
forums = 5.times.map do
  Forum.create!(
    name: Faker::Lorem.word.capitalize,
    user: users.sample
  )
end

# Plants
plants = 10.times.map do
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
gardens = 10.times.map do
  Garden.create!(
    name: Faker::Lorem.word.capitalize,
    user: users.sample,
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
    garden: gardens.sample,
    plant: plants.sample,
    user: users.sample,
    comment: Faker::Lorem.sentence,
    planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    expected_harvest_date: Faker::Date.forward(days: 60)
  )
end

# Massages
30.times do
  Massage.create!(
    content: Faker::Lorem.paragraph,
    forum_id: rand(1..5),
    user_id: rand(1..10)
  )
end

# Recommendations
30.times do
  Recommendation.create!(
    plant: plants.sample,
    text: Faker::Lorem.paragraph,
    trigger_conditions: Faker::Lorem.sentence,
    garden: gardens.sample
  )
end

# Resources
10.times do
  Resource.create!(
    title: Faker::Book.title,
    text: Faker::Lorem.paragraph,
    author: Faker::Book.author,
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "pdf",
    url: Faker::Internet.url
  )
end
