class WeatherFacade
  attr_reader :lat_and_long,
              :location

  def initialize(location)
    @location = location
    @lat_and_long = get_location
    @forecast = get_forecast
  end

  def get_location
    attributes = MapService.lat_and_long(@location)
    @lat_and_long = MapQuest.new(attributes)
  end

  def get_forecast
    forecast = WeatherService.get_forecast(@lat_and_long)
  end
end