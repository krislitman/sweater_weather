class RoadTripWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.zone.at(data[:dt]).in_time_zone('America/New_York').strftime('%I %M %p')
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
    @date = Time.zone.at(data[:dt]).in_time_zone('America/New_York').strftime('%d')
  end
  
  def hour_date
    @date
  end
end