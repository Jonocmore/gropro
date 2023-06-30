require_relative '../../config/openai_config'

require 'net/http'
require 'uri'
require 'json'

class OpenAiService
  def initialize(prompt)
    @prompt = prompt
  end

  def call
    uri = URI('https://api.openai.com/v1/chat/completions')
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{OPENAI_API_KEY}"
    request.content_type = 'application/json'
    request.body = JSON.dump({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": @prompt.to_s
        }
      ]
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts "AI Response: #{response.body}" # Add this line for debugging purposes

    JSON.parse(response.body)

    response_body = JSON.parse(response.body)
    response_text = response_body['choices'][0]['message']['content']

     # Assuming the response text is a list of plant names separated by commas
     recommended_plants = response_text.split(', ')
     recommended_plants

    #  puts "Recommended plants: #{recommended_plants}"  # Add this line

    #  # Get the list of plant names from the database
    #  plants = Plant.all.pluck(:plant_name)

    #  # Check each recommended plant to see if it's in the list from the database
    #  valid_plants = recommended_plants.select { |plant| plants.include?(plant) }

    #  puts "Valid plants: #{valid_plants}"  # Add this line

    #  # Respond with the valid plant names
    #  {message: valid_plants.join(', ')}
  end
end
