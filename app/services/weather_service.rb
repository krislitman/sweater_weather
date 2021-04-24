class WeatherService
  def self.get_forecast(location)
    response = conn.get("data/2.5/onecall") do |req|
      req.params['appid'] = Figaro.env.appid
      req.params['lat'] = location.lat
      req.params['lon'] = location.lng
    end
    JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end

  private

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end