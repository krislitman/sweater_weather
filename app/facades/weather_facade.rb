class WeatherFacade
  attr_reader :lat_and_long,
              :location,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(location)
    @location = location
    @lat_and_long = get_location
    @forecast = get_forecast
    @current_weather = current_weather
  end

  def get_location
    attributes = MapService.lat_and_long(@location)
    @lat_and_long = MapQuest.new(attributes)
  end

  def get_forecast
    forecast = WeatherService.get_forecast(@lat_and_long)
    @current_weather = CurrentWeather.new(forecast)
    @daily_weather = next_five_days(forecast[:daily])
    @hourly_weather = next_eight_hours(forecast[:hourly])
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