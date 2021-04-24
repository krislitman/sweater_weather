class WeatherFacade
  attr_reader :lat_and_long,
              :location

  def initialize(location)
    @location = location
    @lat_and_long = get_location
  end

  def get_location
    attributes = WeatherService.lat_and_long(@location)
    @lat_and_long = MapQuest.new(attributes)
  end
end