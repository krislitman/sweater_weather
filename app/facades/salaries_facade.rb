class SalariesFacade
  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(salaries, destination)
    @destination = destination
    @forecast = find_forecast
    @salaries = salaries
  end

  def find_forecast
    facade = WeatherFacade.new(@destination)
    {
      summary: facade.current_weather.conditions.titleize,
      temperature: facade.current_weather.temperature
    }
  end
end