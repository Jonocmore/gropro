require "open-uri"
require "nokogiri"

# p "Cleaning Database"

# UserResource.destroy_all
# Message.destroy_all
# Resource.destroy_all
# Forum.destroy_all
# Recommendation.destroy_all
# GardenPlant.destroy_all
# Garden.destroy_all
# Plant.destroy_all
# User.destroy_all

puts "Creating Users"

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user1",
  email: "user1@gmail.com",
  password: "password",
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user2",
  email: "user2@gmail.com",
  password: "password",
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user3",
  email: "user3@gmail.com",
  password: "password",
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user4",
  email: "user4@gmail.com",
  password: "password",
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user5",
  email: "user5@gmail.com",
  password: "password",
)

puts "#{User.all.count} users created"

url = "https://www.growveg.co.za/plants/south-africa"
html = URI.open(url).read
doc = Nokogiri::HTML.parse(html, nil, "utf-8")

p "Creating Plants"

doc.search(".plantIndexCell").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  details_url = element.search("a").first["href"]
  link_url = "https://www.growveg.co.za/#{details_url}"
  details_page = Nokogiri::HTML.parse(URI.open(link_url).read, nil, "utf-8")

  src = details_page.search("img.lazyload")
  image_link = src.attribute("data-src").value

  plant_image = image_link
  crop_rotation_group = details_page.search("span#ctl00_ctl00_main_main_lblCropFamily").text.strip
  soil = details_page.search("span#ctl00_ctl00_main_main_lblSoil").text.strip
  position = details_page.search("span#ctl00_ctl00_main_main_lblPosition").text.strip
  frost_tolerant = details_page.search("span#ctl00_ctl00_main_main_lblFrostTolerant").text.strip
  feeding = details_page.search("span#ctl00_ctl00_main_main_lblFeeding").text.strip
  spacing_single_plant = details_page.search("span#ctl00_ctl00_main_main_lblSpacingSingle").text.strip
  spacing_rows = details_page.search("span#ctl00_ctl00_main_main_lblSpacingRows").text.strip
  sow_and_plant = details_page.search("span#ctl00_ctl00_main_main_lblSowPlant").text.strip
  notes = details_page.search("span#ctl00_ctl00_main_main_lblNotes").text.strip
  harvesting = details_page.search("span#ctl00_ctl00_main_main_lblHarvesting").text.strip

  plant = Plant.new(
    plant_image: plant_image,
    plant_name: plant_name,
    crop_rotation_group: crop_rotation_group,
    soil: soil,
    position: position,
    frost_tolerant: frost_tolerant,
    feeding: feeding,
    spacing_single_plant: spacing_single_plant,
    spacing_rows: spacing_rows,
    sow_and_plant: sow_and_plant,
    notes: notes,
    harvesting: harvesting,

  )
  plant.save!
end

puts "#{Plant.all.count} plants created"

# category of plants
p "Allocating Herb Category"
doc.search(".herb").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name: plant_name)
  plant.category = "herb"
  plant.save
end

p "Allocating Fruit Category"
doc.search(".fruit").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name: plant_name)
  plant.category = "fruit"
  plant.save
end

p "Allocating Vegetable Category"
doc.search(".vegetable").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name: plant_name)
  plant.category = "vegetable"
  plant.save
end

p "Allocating Flower Category"
doc.search(".flower").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name: plant_name)
  plant.category = "flower"
  plant.save
end

p "popular"

plant_vegetable = Plant.find_by(plant_name: 'Tomato (Regular)')
plant_vegetable.popular = true
plant_vegetable.save

plant_vegetable = Plant.find_by(plant_name: 'Beans (Dry)')
plant_vegetable.popular = true
plant_vegetable.save

plant_vegetable = Plant.find_by(plant_name: 'Chilli Pepper')
plant_vegetable.popular = true
plant_vegetable.save

plant_fruit = Plant.find_by(plant_name: 'Apple (Cordon)')
plant_fruit.popular = true
plant_fruit.save

plant_fruit = Plant.find_by(plant_name: 'Nectarine (Dwarf)')
plant_fruit.popular = true
plant_fruit.save

plant_fruit = Plant.find_by(plant_name: 'Orange')
plant_fruit.popular = true
plant_fruit.save

plant_herb = Plant.find_by(plant_name: 'Parsley')
plant_herb.popular = true
plant_herb.save

plant_herb = Plant.find_by(plant_name: 'Basil')
plant_herb.popular = true
plant_herb.save

plant_herb = Plant.find_by(plant_name: 'Oregano')
plant_herb.popular = true
plant_herb.save

plant_flower = Plant.find_by(plant_name: 'Rose')
plant_flower.popular = true
plant_flower.save

plant_flower = Plant.find_by(plant_name: 'Cornflower')
plant_flower.popular = true
plant_flower.save

plant_flower = Plant.find_by(plant_name: 'Daylily')
plant_flower.popular = true
plant_flower.save

# Gardens

p "Creating Gardens"

Garden.create!(
  name: Faker::Lorem.word.capitalize,
  user_id: 1,
  date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
  location: "unknown",
  sunlight: rand(0..100),
  size: rand(1..50),
  outside: [true, false].sample,
  created_at: Time.current,
  updated_at: Time.current,
)

Garden.create!(
  name: Faker::Lorem.word.capitalize,
  user_id: 1,
  date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
  location: "unknown",
  sunlight: rand(0..100),
  size: rand(1..50),
  outside: [true, false].sample,
  created_at: Time.current,
  updated_at: Time.current,
)

Garden.create!(
  name: Faker::Lorem.word.capitalize,
  user_id: 2,
  date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
  location: "unknown",
  sunlight: rand(0..100),
  size: rand(1..50),
  outside: [true, false].sample,
  created_at: Time.current,
  updated_at: Time.current,
)

Garden.create!(
  name: Faker::Lorem.word.capitalize,
  user_id: 2,
  date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
  location: "unknown",
  sunlight: rand(0..100),
  size: rand(1..50),
  outside: [true, false].sample,
  created_at: Time.current,
  updated_at: Time.current,
)

puts "#{Garden.all.count} Gardens Created"

# GardenPlants

p "garden_plants"

# 10.times do
#   garden = Garden.order("RANDOM()").first
#   plant = Plant.order("RANDOM()").first
#   user = User.order("RANDOM()").first

GardenPlant.create!(
  garden_id: 1,
  plant_id: rand(1..244),
  user_id: 1,
  comment: Faker::Lorem.sentence,
  planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
  expected_harvest_date: Faker::Date.forward(days: 60),
)

GardenPlant.create!(
  garden_id: 2,
  plant_id: rand(1..244),
  user_id: 1,
  comment: Faker::Lorem.sentence,
  planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
  expected_harvest_date: Faker::Date.forward(days: 60),
)

GardenPlant.create!(
  garden_id: 3,
  plant_id: rand(1..244),
  user_id: 2,
  comment: Faker::Lorem.sentence,
  planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
  expected_harvest_date: Faker::Date.forward(days: 60),
)

GardenPlant.create!(
  garden_id: 4,
  plant_id: rand(1..244),
  user_id: 1,
  comment: Faker::Lorem.sentence,
  planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
  expected_harvest_date: Faker::Date.forward(days: 60),
)
# end

# Recommendations

p "Creating Recommendations"

10.times do
  Recommendation.create!(
    plant_id: rand(1..244),
    text: Faker::Lorem.paragraph,
    trigger_conditions: Faker::Lorem.sentence,
    garden_id: Garden.order("RANDOM()").first.id || 1,
  )
end

puts "#{Recommendation.all.count} Recommendations Created"

# Forums

p "Creating Forums"

Forum.create!(
  name: "Market Place",
  user_id: 1,
)

Forum.create!(
  name: "General",
  user_id: 2,
)

Forum.create!(
  name: "Help",
  user_id: 3,
)

puts "#{Forum.all.count} Forums Created"

# Messages

p "Creating Forum Messages"

  Message.create!(
    content: Faker::Lorem.paragraph,
    forum_id: 1,
    user_id: 1
  )

  Message.create!(
    content: Faker::Lorem.paragraph,
    forum_id: 2,
    user_id: 1
  )

  Message.create!(
    content: Faker::Lorem.paragraph,
    forum_id: 1,
    user_id: 2
  )

  Message.create!(
    content: Faker::Lorem.paragraph,
    forum_id: 2,
    user_id: 2
  )

puts "#{Message.all.count} Messages Created"

# Resources

p "Creating Resources"

  Resource.create!(
    title: 'Benefits of Gardening',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "benefits_of_garden_resource.png",
    url: 'https://gardening.co.za/pages/benefits-of-gardening',
    popular: true
  )

  Resource.create!(
    title: 'Potato Grow',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "potato_resource.png",
    url: 'https://gardening.co.za/pages/potato-grow-care-guides',
    popular: false
  )

  Resource.create!(
    title: 'Green House Growing',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "greenhouse_resource.png",
    url: 'https://gardening.co.za/pages/growing-in-green-houses-guides',
    popular: true
  )

  Resource.create!(
    title: 'Worm Farming',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "worm_resource.png",
    url: 'https://gardening.co.za/pages/vermiculture-worm-farming-guides',
    popular: false
  )

  Resource.create!(
    title: 'Tomato Guides',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "tomato_resource.png",
    url: 'https://gardening.co.za/pages/tomato-grow-care-guides',
    popular: true
  )

  Resource.create!(
    title: 'Citrus & Fruit',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "citrus_resource.png",
    url: 'https://gardening.co.za/pages/citrus-fruit-guides',
    popular: false
  )

  Resource.create!(
    title: 'Weed Control',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "weed_resource.png",
    url: 'https://gardening.co.za/pages/weed-control',
    popular: true
  )

  Resource.create!(
    title: 'Herb & Veggies',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "herb_resource.png",
    url: 'https://gardening.co.za/pages/herb-veggie-guides',
    popular: false
  )

  Resource.create!(
    title: 'Farming Gods Way',
    text: '',
    author: 'farming-gods-way.org',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "farming.png",
    url: 'https://www.farming-gods-way.org/vegetable_guide.htm',
    popular: true
  )

  Resource.create!(
    title: 'Flower Guides',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "flower_resource.png",
    url: 'https://gardening.co.za/pages/flower-growing-care-guides',
    popular: false
  )

  Resource.create!(
    title: 'Eco Composting',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "eco_resource.png",
    url: 'https://gardening.co.za/pages/eco-composting-guides',
    popular: false
  )

  Resource.create!(
    title: 'Raised Garden Beds',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "bed_resource.png",
    url: 'https://gardening.co.za/pages/raised-garden-beds-grow-bag-guides',
    popular: false
  )

  Resource.create!(
    title: 'Chilli Peppers',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "chilli_resource.png",
    url: 'https://gardening.co.za/pages/chilli-pepper-guides',
    popular: false
  )

  Resource.create!(
    title: 'Pest Control',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "pest_resource.png",
    url: 'https://gardening.co.za/pages/pest-control-guides',
    popular: true
  )

  Resource.create!(
    title: 'Indoor Plants',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "indoor_resource.png",
    url: 'https://gardening.co.za/pages/indoor-plant-guides',
    popular: false
  )

  Resource.create!(
    title: 'Seed And Seedlings',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "seed_resource.png",
    url: 'https://gardening.co.za/pages/seed-seedling-guides',
    popular: true
  )

  Resource.create!(
    title: 'Succulent Guides',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "succulent_resource.png",
    url: 'https://gardening.co.za/pages/seed-seedling-guides',
    popular: false
  )

  Resource.create!(
    title: 'Soil Care',
    text: '',
    author: 'gardening.co.za',
    date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    file_type: "soil_resource.png",
    url: 'https://gardening.co.za/pages/soil-care-guides',
    popular: true
  )



puts "#{Resource.all.count} Resources Created"

# User_resources

p "User_Resources"

10.times do
  UserResource.create!(
    user_id: rand(1..5),
    resource_id: rand(1..10),
    is_favorite: false,
  )
end
