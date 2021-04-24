class BackgroundsFacade
  attr_reader :location,
              :image,
              :credit

  def initialize(location)
    @location = location
    @facade = WeatherFacade.new(location)
    @conditions = @facade.current_weather.conditions
    @time = @facade.current_weather.datetime.strftime('%I %M %p')
    @time_of_day_conditions = time_of_day
    @image = background_image
    @credit = @image.credit
  end

  def background_image
    @image = BackgroundsService.background_image(@location, @time_of_day_conditions)
    @image = BackgroundsService.background_image(@location) if @image.nil?
  end

  def time_of_day
    if @time[1].to_i >= 6 && @time[6] == 'A'
      "morning #{@conditions}"
    elsif @time[0].to_i == 1 && @time[6] == 'P'
      "morning #{@conditions}"
    elsif @time[1].to_i >= 1 && @time[1].to_i <= 5 && @time[6] == 'P'
      "afternoon #{@conditions}"
    elsif @time[1].to_i >= 6 && @time[6] == 'P'
      "evening #{@conditions}"
    elsif @time[1].to_i <= 5 && @time[6] == 'A'
      "night #{@conditions}"
    elsif @time[0].to_i == 1 && @time[6] == 'A'
      "night #{@conditions}"
    end
  end
end
