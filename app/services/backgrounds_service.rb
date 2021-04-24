class BackgroundsService 
  def self.get_image(location)
    facade = WeatherFacade.new(location)
    conditions = facade.current_weather.conditions
    time = facade.current_weather.datetime.strftime("%I %M %p")
    
    case 
    when time[1].to_i >= 6 && time[6] == 'A'
      current_conditions = "morning #{conditions}"
    when time[0].to_i == 1 && time[6] == 'P'
      current_conditions = "morning #{conditions}"
    when time[1].to_i >= 1 && time[1].to_i <= 5 && time[6] == 'P'
      current_conditions = "afternoon #{conditions}"
    when time[1].to_i >= 6 && time[6] == 'P'
      current_conditions = "evening #{conditions}"
    when time[1].to_i <= 5 && time[6] == 'A'
      current_conditions = "night #{conditions}"
    when time[0].to_i == 1 && time[6] == 'A'
      current_conditions = "night #{conditions}"
    end
    require 'pry'; binding.pry

    cleaned = location.split(',').join(" ").concat(" city skyline #{current_conditions}")

    conn = Faraday.new('https://api.flickr.com')
    
    response = conn.get('services/rest') do |req|
      req.params['method'] = 'flickr.photos.search'
      req.params['per_page'] = '5'
      req.params['text'] = cleaned
      req.params['api_key'] = Figaro.env.api_key
      req.params['extras'] = 'owner_name'
      req.params['extras'] = 'description'
      req.params['extras'] = 'path_alias'
      req.params['extras'] = 'url_c'
      req.params['format'] = 'json'
      req.params['nojsoncallback'] = '1'
    end
    data = JSON.parse(response.body, symbolize_names: true)
  end
end