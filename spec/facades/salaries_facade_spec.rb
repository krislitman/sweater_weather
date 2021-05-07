# require 'rails_helper'

# RSpec.describe SalariesFacade do
#   it 'can be created with attributes' do
#     expected = SalariesFacade.new('denver,co')

#     expect(expected).to be_an_instance_of(SalariesFacade)
#     expect(expected.forecast.keys).to include(:summary)
#     expect(expected.forecast.keys).to include(:temperature)
#     expect(expected.salaries).to be_an(Array)
#     expect(expected.salaries[0]).to be_an_instance_of(Job)
#   end
#   it '#find_forecast' do
#     expected = SalariesFacade.new('denver,co')
#     forecast = expected.find_forecast
    
#     expect(forecast).to be_a(Hash)
#     expect(expected.forecast.keys).to include(:summary)
#     expect(expected.forecast.keys).to include(:temperature)
#   end
# end