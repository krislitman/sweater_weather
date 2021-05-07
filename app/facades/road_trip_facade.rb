class RoadTripFacade
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    @start_city = data[:origin]
    @end_city = data[:destination]
    @lat_and_long = destination_coordinates
    @travel_time = MapService.travel_time(@start_city, @end_city)
    @weather_at_eta = find_weather
  end

  def destination_coordinates
    return nil if @end_city.blank?
    coordinates = MapService.lat_and_long(@end_city)
    MapQuest.new(coordinates)
  end

  def find_weather
    arrival_time = find_arrival_time
    return current_weather if arrival_time == 'current_weather'

    weather = WeatherService.road_trip(@lat_and_long, arrival_time)
    if weather
      good_weather(weather)
    else
      impossible
    end
  end

  def find_arrival_time
    current_time = Time.zone.now.strftime('%I %M %p %d')
    return impossible if @travel_time.nil?

    time = Time.zone.now + @travel_time[0..1].to_i.hour + @travel_time[3..4].to_i.minutes
    arrival_time = time.strftime('%I %M %p %d')
    if current_time[9..10] == arrival_time[9..10] && current_time[6..7] == arrival_time[6..7] &&
       current_time[0..1].to_i - arrival_time[0..1].to_i <= 2
      'current_weather'
    else
      arrival_time
    end
  end

  private

  def current_weather
    forecast = WeatherService.find_forecast(@lat_and_long, 'imperial')
    current_weather = CurrentWeather.new(forecast)
    {
      temperature: current_weather.temperature,
      conditions: current_weather.conditions
    }
  end

  def good_weather(weather)
    {
      temperature: weather.temperature,
      conditions: weather.conditions
    }
  end

  def impossible
    {
      temperature: [],
      conditions: 'impossible'
    }
  end
end
