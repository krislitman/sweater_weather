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
    facade.current_weather
  end
end