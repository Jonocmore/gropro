module ApplicationHelper
  def generate_response
    api_key = ENV.fetch("OPENAI_ACCESS_KEY")
    engine = "text-davinci-003"
    prompt = "What Apples can I grow in Port Elizabeth?"
    openai_client = OpenAI::Client.new(api_key: api_key, default_engine: engine)
    response = openai_client.completions(prompt: prompt, max_tokens: 4000, engine: engine)
    text = response.choices[0].text
  end
end
