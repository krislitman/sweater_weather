require 'rails_helper'

RSpec.describe MapService do
  it 'Returns proper data from MapQuest' do
    VCR.use_cassette('services/map_service_spec',
    match_requests_on: %i[body]) do
      response = MapService.lat_and_long('Denver,CO')

      expect(response).to be_a(Hash)
      expect(response[:results][0][:providedLocation][:location]).to eq('Denver,CO')
      expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.738453)
      expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.984853)
    end
  end
end