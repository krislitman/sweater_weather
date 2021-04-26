class SalariesService
  def self.destination_salaries(destination)
    response = conn.get("api/urban_areas/slug:#{destination}/salaries")
    expected = JSON.parse(response.body, symbolize_names: true)
    jobs = expected[:salaries].map do |data|
      Job.new(data)
    end
    relevant_jobs(jobs)
  end

  def self.relevant_jobs(jobs)
    jobs.find_all do |job|
      job.title == 'Data Analyst' || job.title == 'Data Scientist' ||
      job.title == 'Mobile Developer' || job.title == 'QA Engineer' ||
      job.title == 'Software Engineer' || job.title == 'Systems Administrator' ||
      job.title == 'Web Developer'
    end
  end

  private

  def self.conn
    Faraday.new('http://api.teleport.org')
  end
end