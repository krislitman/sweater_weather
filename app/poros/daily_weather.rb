class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = Time.zone.at(data[:dt]).in_time_zone('America/New_York').strftime('%m %d %y')
    @sunrise = Time.zone.at(data[:sunrise]).in_time_zone('America/New_York')
    @sunset = Time.zone.at(data[:sunset]).in_time_zone('America/New_York')
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
