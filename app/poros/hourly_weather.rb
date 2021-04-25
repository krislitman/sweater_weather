class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.zone.at(data[:dt]).strftime('%I %M %p')
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
    @date = Time.zone.at(data[:dt]).strftime('%d')
  end

  def hour_date
    @date
  end
end
