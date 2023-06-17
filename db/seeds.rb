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
