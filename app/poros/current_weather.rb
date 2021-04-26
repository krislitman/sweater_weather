class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = Time.zone.at(data[:current][:dt]).in_time_zone('America/New_York')
    @sunrise = Time.zone.at(data[:current][:sunrise]).in_time_zone('America/New_York')
    @sunset = Time.zone.at(data[:current][:sunset]).in_time_zone('America/New_York')
    @temperature = data[:current][:temp]
    @feels_like = data[:current][:feels_like]
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uvi]
    @visibility = data[:current][:visibility]
    @conditions = data[:current][:weather][0][:description]
    @icon = data[:current][:weather][0][:icon]
  end
end
