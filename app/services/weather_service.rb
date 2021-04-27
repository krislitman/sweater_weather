class WeatherService
  def self.find_forecast(location, units)
    response = conn.get('data/2.5/onecall') do |req|
      req.params['appid'] = Figaro.env.appid
      req.params['lat'] = location.lat
      req.params['lon'] = location.lng
      req.params['units'] = units
      req.params['exclude'] = 'alerts,minutely'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.road_trip(location, time)
    response = conn.get('data/2.5/onecall') do |req|
      req.params['appid'] = Figaro.env.appid
      req.params['lat'] = location.lat
      req.params['lon'] = location.lng
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'alerts,minutely'
    end
    expected = JSON.parse(response.body, symbolize_names: true)
    weather_data(expected[:hourly], time)
  end

  def self.weather_data(data, time)
    expected = data.map do |hour|
      HourlyWeather.new(hour)
    end
    expected.find do |hour|
      hour.hour_date == time[9..10] &&
      hour.time[6..7] == time[6..7] &&
      hour.time[0..1] == time[0..1]
    end
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end
