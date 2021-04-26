class SalariesFacade
  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(destination)
    @destination = destination
    @forecast = find_forecast
    @salaries = find_salaries
  end

  def find_salaries
    response = conn.get("api/urban_areas/slug:#{@destination}/salaries")
    expected = JSON.parse(response.body, symbolize_names: true)
    jobs = expected[:salaries].map do |data|
      Job.new(data)
    end
    relevant_jobs(jobs)
  end

  def find_forecast
    facade = WeatherFacade.new(@destination)
    {
      summary: facade.current_weather.conditions.titleize,
      temperature: facade.current_weather.temperature
    }
  end

  def relevant_jobs(jobs)
    jobs.find_all do |job|
      job.title == 'Data Analyst' || job.title == 'Data Scientist' ||
      job.title == 'Mobile Developer' || job.title == 'QA Engineer' ||
      job.title == 'Software Engineer' || job.title == 'Systems Administrator' ||
      job.title == 'Web Developer'
    end
  end

  private

  def conn
    Faraday.new('http://api.teleport.org')
  end
end