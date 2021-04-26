class SalariesService
  TECH_JOBS = ['Data Analyst', 'Data Scientist',
    'Mobile Developer', 'QA Engineer', 'Software Engineer',
    'Systems Administrator', 'Web Developer']

  def self.destination_salaries(destination)
    response = conn.get("api/urban_areas/slug:#{destination}/salaries")
    expected = JSON.parse(response.body, symbolize_names: true)
    all_jobs = expected[:salaries].map do |data|
      Job.new(data)
    end
    find_relevant_jobs(all_jobs)
  end

  def self.find_relevant_jobs(all_jobs)
    all_jobs.find_all do |job|
      job if TECH_JOBS.include?(job.title)
    end
  end

  private

  def self.conn
    Faraday.new('http://api.teleport.org')
  end
end