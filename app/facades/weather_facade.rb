class WeatherFacade
  attr_reader :lat_and_long,
              :location,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(location, units = 'imperial')
    @location = location
    @lat_and_long = find_location
    @units = units
    @forecast = find_forecast
    @current_weather = current_weather
  end

  def find_location
    return nil if @location.to_s == @location.to_i.to_s || @location.blank?
    Rails.cache.fetch "location #{@location}", expires_in: 1.week do
      attributes = MapService.lat_and_long(@location)
      @lat_and_long = MapQuest.new(attributes)
    end
  end

  def find_forecast
    begin
      return nil if @location.to_s == @location.to_i.to_s || @location.blank? 
      forecast = WeatherService.find_forecast(@lat_and_long, @units)
      @current_weather = CurrentWeather.new(forecast)
      @daily_weather = next_five_days(forecast[:daily])
      @hourly_weather = next_eight_hours(forecast[:hourly])
    rescue 
      nil
    end
  end

  def next_five_days(forecast)
    forecast[0..4].map do |day|
      DailyWeather.new(day)
    end
  end

  def next_eight_hours(forecast)
    forecast[0..7].map do |hour|
      HourlyWeather.new(hour)
    end
  end
end
