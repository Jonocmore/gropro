require "faker"

# Users
users = 10.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    username: Faker::Internet.unique.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
end

# Forums
forums = 5.times.map do
  Forum.create!(
    name: Faker::Lorem.word.capitalize,
    user: users.sample,
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
    lifecycle: ["Annual", "Perennial", "Biennial"].sample,
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
    outside: [true, false].sample,
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
    expected_harvest_date: Faker::Date.forward(days: 60),
  )
end

# Massages
30.times do
  Massage.create!(
    content: Faker::Lorem.paragraph,
    forum_id: rand(1..5),
    user_id: rand(1..10),
  )
end

# Recommendations
30.times do
  Recommendation.create!(
    plant: plants.sample,
    text: Faker::Lorem.paragraph,
    trigger_conditions: Faker::Lorem.sentence,
    garden: gardens.sample,
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
    url: Faker::Internet.url,
  )
end

# require_relative "../app/models/plant"
require "open-uri"
require "nokogiri"

url = "https://www.growveg.co.za/plants/south-africa"
html = URI.open(url).read
doc = Nokogiri::HTML.parse(html, nil, "utf-8")

element = doc.search(".plantIndexCell").first
name = element.search(".plantIndexText").text.strip
details_url = element.search("a").first["href"]
link_url = "https://www.growveg.co.za/#{details_url}"
details_page = Nokogiri::HTML.parse(URI.open(link_url).read, nil, "utf-8")

src = details_page.search("img.lazyload")
image_link = src.attribute("data-src").value

headings = [
  "plant_image",
  "plant_name",
  "crop_rotation_group",
  "soil",
  "position",
  "frost_tolerant",
  "feeding",
  "spacing_single_plant",
  "spacing_rows",
  "sow_and_plant",
  "notes",
  "harvesting",
]
values = [
  image_link,
  name,
  details_page.search("span#ctl00_ctl00_main_main_lblCropFamily").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblSoil").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblPosition").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblFrostTolerant").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblFeeding").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblSpacingSingle").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblSpacingRows").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblSowPlant").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblNotes").text.strip,
  details_page.search("span#ctl00_ctl00_main_main_lblHarvesting").text.strip,
]

my_hash = {}
headings.each_with_index do |heading, index|
  my_hash[heading] = values[index]
end

my_hash.each do |heading, value|
  puts "#{heading}: #{value}"

  # plant_attributes = {}
  # headings.each_with_index do |heading, index|
  #   plant_attributes[heading] = values[index]

  # plant_attributes = Hash[headings.zip(values)]

  # Plant.create!(plant_attributes)
end
