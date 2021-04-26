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
    complete_forecast = WeatherFacade.new(@destination)
    {
      summary: complete_forecast.current_weather.conditions.titleize,
      temperature: complete_forecast.current_weather.temperature
    }
  end
end