class WeatherService
  def self.find_forecast(location, units)
    begin
      return nil if units.to_s == units.to_i.to_s
      response = conn.get('data/2.5/onecall') do |req|
        req.params['appid'] = Figaro.env.appid
        req.params['lat'] = location.lat
        req.params['lon'] = location.lng
        req.params['units'] = units
        req.params['exclude'] = 'alerts,minutely'
      end
      JSON.parse(response.body, symbolize_names: true)
    rescue
      nil
    end
  end

  def self.road_trip(location, time)
    begin
      response = conn.get('data/2.5/onecall') do |req|
        req.params['appid'] = Figaro.env.appid
        req.params['lat'] = location.lat
        req.params['lon'] = location.lng
        req.params['units'] = 'imperial'
        req.params['exclude'] = 'alerts,minutely'
      end
      expected = JSON.parse(response.body, symbolize_names: true)
      weather_data(expected[:hourly], time)
    rescue 
      nil
    end
  end

  def self.weather_data(data, time)
    begin
      expected = data.map do |hour|
        RoadTripWeather.new(hour)
      end
      expected.find do |hour|
        hour.hour_date == time[9..10] &&
        hour.time[6..7] == time[6..7] &&
        hour.time[0..1] == time[0..1]
      end
    rescue
      nil
    end
  end

  private

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end
