require 'rails_helper'

RSpec.describe SalariesService do
  it '#destination_salaries' do
    expected = SalariesService.destination_salaries('denver')

    expect(expected).to be_an(Array)
    expect(expected.count).to eq(7)
    expect(expected[0]).to be_an_instance_of(Job)
    expect(expected[0].title).to be_a(String)
    expect(expected[0].min).to be_a(String)
    expect(expected[0].max).to be_a(String)
  end
  it '#find_relevant_jobs' do
    job1 = Job.new(
      {:job=>
      {:id=>"COPYWRITER", 
        :title=>"Copywriter"}, 
        :salary_percentiles=>
      {:percentile_25=>49499.128653877684, 
        :percentile_50=>60866.315693952405, 
        :percentile_75=>74843.91113348732}})
    job2 = Job.new(
      {:job=>
        {:id=>"CUSTOMER-SUPPORT", 
          :title=>"Customer Support"}, 
          :salary_percentiles=>
          {:percentile_25=>28178.119866978843, 
            :percentile_50=>36227.84618512116, 
            :percentile_75=>46577.161478783746}})
    job3 = Job.new({:job=>
      {:id=>"DATA-ANALYST", 
        :title=>"Data Analyst"}, 
        :salary_percentiles=>
        {:percentile_25=>42878.34161807408, 
          :percentile_50=>51604.570316663645, 
          :percentile_75=>62106.68549841864}})
    jobs = [job1, job2, job3]
    expected = SalariesService.find_relevant_jobs(jobs)

    expect(expected).to be_an(Array)
    expect(expected.count).to eq(1)
    expect(expected).not_to include(job1)
    expect(expected).not_to include(job2)
    expect(expected).to include(job3)
  end
end