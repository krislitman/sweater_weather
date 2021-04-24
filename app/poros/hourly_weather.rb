class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon
  def initialize(data)
    @time = Time.at(data[:dt]).strftime("%I %M %p")
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end