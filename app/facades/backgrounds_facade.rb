class BackgroundsFacade
  attr_reader :location,
              :image,
              :credit

  def initialize(location)
    @location = location
    @conditions = find_conditions
    @time = find_time
    @time_of_day_conditions = time_of_day
    @image = background_image
  end

  def find_time
    facade = WeatherFacade.new(@location)
    @time = facade.current_weather.datetime.strftime('%I %M %p')
  end

  def find_conditions
    facade = WeatherFacade.new(@location)
    @conditions = facade.current_weather.conditions
  end

  def background_image
    @image = BackgroundsService.background_image(@location, @time_of_day_conditions)
    @image = BackgroundsService.background_image(@location) if @image.nil?
    @credit = @image.credit
    @image
  end

  def time_of_day
    if @time[1].to_i >= 6 && @time[6] == 'A'
      "morning #{@conditions}"
    elsif @time[0].to_i == 1 && @time[6] == 'P' && @time[1].to_i == 2 
      "morning #{@conditions}"
    elsif @time[1].to_i >= 1 && @time[1].to_i <= 5 && @time[6] == 'P' &&
      @time[0].to_i != 1
      "afternoon #{@conditions}"
    elsif @time[1].to_i >= 6 && @time[6] == 'P'
      "evening #{@conditions}"
    elsif (@time[1].to_i <= 5 && @time[6] == 'A') || 
      (@time[0].to_i == 1 && @time[6] == 'P')
      "night #{@conditions}"
    end
  end
end
