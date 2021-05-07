class SalariesFacade
  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(destination)
    @destination = destination
    @forecast = find_forecast
    @salaries = SalariesService.destination_salaries(@destination)
  end

  def find_forecast
    attributes = MapService.lat_and_long(@destination)
    lat_and_long = MapQuest.new(attributes)
    forecast = WeatherService.find_forecast(lat_and_long, @units)
    complete_forecast = CurrentWeather.new(forecast)
    {
      summary: complete_forecast.conditions.titleize,
      temperature: complete_forecast.temperature
    }
  end
end