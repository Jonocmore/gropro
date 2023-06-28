class ChatController < ApplicationController
  def index
    @garden_types = Plant.all
    api_key = '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'
    user_message = "what is your name?"

    uri = URI('https://api.openai.com/v1/chat/completions')
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request["Authorization"] = "Bearer #{api_key}"
    request.body = JSON.dump({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": user_message
        }
      ]
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts response.code
    response = JSON.parse(response.body)
    puts response
    response_text = response['choices'][0]['message']['content']

    puts "Response from OpenAI: #{response_text}"  # Add this line

    # Assuming the response text is a list of plant names separated by commas
    recommended_plants = response_text.split(', ')

    puts "Recommended plants: #{recommended_plants}"  # Add this line

    # Get the list of plant names from the database
    plants = Plant.all.pluck(:plant_name)

    # Check each recommended plant to see if it's in the list from the database
    valid_plants = recommended_plants.select { |plant| plants.include?(plant) }

    puts "Valid plants: #{valid_plants}"  # Add this line

    # Respond with the valid plant names
    render json: {message: valid_plants.join(', ')}
  end
end
