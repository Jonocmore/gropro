require "open-uri"
require "nokogiri"
Plant.destroy_all
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

  # plant_image = "plant_image"
  # plant_name = "plant_name"
  # crop_rotation_group = "crop_rotation_group"
  # soil = "soil"
  # position = "position"
  # frost_tolerant = "frost_tolerant"
  # feeding = "feeding"
  # spacing_single_plant = "spacing_single_plant"
  # spacing_rows = "spacing_rows"
  # sow_and_plant = "sow_and_plant"
  # notes = "notes"
  # harvesting = "harvesting"

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
