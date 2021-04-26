class Api::V1::SalariesController < ApplicationController
  def tech_salaries
    response = conn.get("api/urban_areas/slug:#{params[:destination]}/salaries")
    expected = JSON.parse(response.body, symbolize_names: true)
    jobs = expected[:salaries].map do |data|
      Job.new(data)
    end
    relevant_jobs(jobs)
  end

  def relevant_jobs(jobs)
    expected = jobs.find_all do |job|
      job.title == 'Data Analyst' || job.title == 'Data Scientist' ||
      job.title == 'Mobile Developer' || job.title == 'QA Engineer' ||
      job.title == 'Software Engineer' || job.title == 'Systems Administrator' ||
      job.title == 'Web Developer'
    end
    salaries = SalariesFacade.new(expected, params[:destination])
    render json: SalariesSerializer.new(salaries)
  end

  private

  def conn
    Faraday.new('http://api.teleport.org')
  end
end