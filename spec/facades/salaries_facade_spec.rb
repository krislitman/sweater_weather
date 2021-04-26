require 'rails_helper'

RSpec.describe SalariesFacade do
  it 'can be created with attributes' do
    expected = SalariesFacade.new('chicago')

    expect(expected).to be_an_instance_of(SalariesFacade)
    expect(expected.destination).to eq('chicago')
    expect(expected.forecast.keys).to include(:summary)
    expect(expected.forecast.keys).to include(:temperature)
    expect(expected.salaries).to be_an(Array)
    expect(expected.salaries[0]).to be_an_instance_of(Job)
  end
  it '#find_forecast' do
    expected = SalariesFacade.new('chicago')
    forecast = expected.find_forecast
    
    expect(forecast).to be_a(Hash)
    expect(expected.forecast.keys).to include(:summary)
    expect(expected.forecast.keys).to include(:temperature)
  end
end