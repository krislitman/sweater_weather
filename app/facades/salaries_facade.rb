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
    facade = WeatherFacade.new(@destination)
    {
      summary: facade.current_weather.conditions.titleize,
      temperature: facade.current_weather.temperature
    }
  end
end