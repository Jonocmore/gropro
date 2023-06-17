require "open-uri"
require "nokogiri"

puts "Creating users"

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user1",
  email: "user1@gmail.com",
  password: "password"
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user2",
  email: "user2@gmail.com",
  password: "password"
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user3",
  email: "user3@gmail.com",
  password: "password"
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user4",
  email: "user4@gmail.com",
  password: "password"
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  username: "user5",
  email: "user5@gmail.com",
  password: "password"
)

puts "#{User.all.count} users created"

url = "https://www.growveg.co.za/plants/south-africa"
html = URI.open(url).read
doc = Nokogiri::HTML.parse(html, nil, "utf-8")
p "plant"
doc.search(".plantIndexCell").each do |element|
  # element = doc.search(".plantIndexCell").first
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
  # water_schedule = ["Daily", "Weekly", "Monthly"].sample
  # location = Faker::Address.city
  # how_to
  # sunlight = rand(0..100)
  # size = rand(1..50)
  # lifecycle = ["Annual", "Perennial", "Biennial"].sample

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
    # water_schedule: water_schedule,
    # location: location,
    # how_to: how_to,
    # sunlight: sunlight,
    # size: size,
    # lifecycle: lifecycle,
  )
  plant.save!
end

p "herb"
doc.search(".herb").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name:)
  plant.category = "herb"
  plant.save
end

p "fruit"
doc.search(".fruit").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name:)
  plant.category = "fruit"
  plant.save
end

p "vegetable"
doc.search(".vegetable").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name:)
  plant.category = "vegetable"
  plant.save
end

p "flower"
doc.search(".flower").each do |element|
  plant_name = element.search(".plantIndexText").text.strip
  plant = Plant.find_by(plant_name:)
  plant.category = "flower"
  plant.save
end

# Gardens

p "garden"

10.times.map do
  Garden.create!(
    name: Faker::Lorem.word.capitalize,
    user_id: rand(1..5),
    date_planted: Faker::Date.between(from: 2.years.ago, to: Date.today),
    # location: Faker::Address.city,
    sunlight: rand(0..100),
    size: rand(1..50),
    outside: [true, false].sample
  )
end

# GardenPlants

p "garden_plants"

10.times do
  GardenPlant.create!(
    garden_id: rand(1..10),
    plant_id: rand(1..246),
    user_id: rand(1..5),
    comment: Faker::Lorem.sentence,
    planting_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    expected_harvest_date: Faker::Date.forward(days: 60)
  )
end

# Recommendations

p "recommendations"

10.times do
  Recommendation.create!(
    plant_id: rand(1..246),
    text: Faker::Lorem.paragraph,
    trigger_conditions: Faker::Lorem.sentence,
    garden_id: rand(1..10)
  )
end

# Forums

p "forums"

5.times.map do
  Forum.create!(
    name: Faker::Lorem.word.capitalize,
    user_id: rand(1..5)
  )
end

# Messages

p "messages"

10.times do
  Message.create!(
    content: Faker::Lorem.paragraph,
    forum_id: rand(1..5),
    user_id: rand(1..5)
  )
end

# Resources

p "resources"

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

# User_resources

p "user_resources"

10.times do
  UserResource.create!(
    user_id: rand(1..5),
    resource_id: rand(1..10),
    is_favorite: false
  )
end
