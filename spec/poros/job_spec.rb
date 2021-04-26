require 'rails_helper'

RSpec.describe Job do
  it "Can be created with attributes" do
    attributes = {
      :job=>{:id=>"ACCOUNT-MANAGER",
      :title=>"Account Manager"}, 
      :salary_percentiles=>{
        :percentile_25=>53732.4997858553, 
        :percentile_50=>67273.75507905365, 
        :percentile_75=>84227.57438186172
        }
      }
    expected = Job.new(attributes)
    
    expect(expected).to be_an_instance_of(Job)
    expect(expected.title).to eq('Account Manager')
    expect(expected.min).to eq('$53,732.49')
    expect(expected.max).to eq('$84,227.57')
  end
end