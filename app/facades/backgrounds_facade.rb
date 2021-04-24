class BackgroundsFacade
  attr_reader :location,
              :image,
              :credit

  def initialize(location)
    @location = location
    @facade = WeatherFacade.new(location)
    @conditions = @facade.current_weather.conditions
    @time = @facade.current_weather.datetime.strftime("%I %M %p")
    @time_of_day_conditions = get_time_of_day
    @image = get_image
    @credit = @image.credit
  end

  def get_image
    @image = BackgroundsService.get_image(@location, @time_of_day_conditions)
    if @image.nil?
      @image = BackgroundsService.get_image(@location)
    end
  end

  def get_time_of_day
    case 
    when @time[1].to_i >= 6 && @time[6] == 'A'
      "morning #{@conditions}"
    when @time[0].to_i == 1 && @time[6] == 'P'
      "morning #{@conditions}"
    when @time[1].to_i >= 1 && @time[1].to_i <= 5 && @time[6] == 'P'
      "afternoon #{@conditions}"
    when @time[1].to_i >= 6 && @time[6] == 'P'
      "evening #{@conditions}"
    when @time[1].to_i <= 5 && @time[6] == 'A'
      "night #{@conditions}"
    when @time[0].to_i == 1 && @time[6] == 'A'
      "night #{@conditions}"
    end
  end
end