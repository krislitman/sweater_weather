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
  it 'Sad Path ~ Returns nil if no response' do
    VCR.use_cassette('services/map_service_spec_sad_1',
    match_requests_on: %i[body]) do
      response = MapService.lat_and_long(1234567)
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Returns nil if travel time is wrong' do
    VCR.use_cassette('services/map_service_spec_sad_2',
    match_requests_on: %i[body]) do
      response = MapService.travel_time(123, 456)
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Returns nil if travel time is wrong 2' do
    VCR.use_cassette('services/map_service_spec_sad_3',
    match_requests_on: %i[body]) do
      response = MapService.travel_time("NO WHERE", "12345")
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Returns nil if EMPTY' do
    VCR.use_cassette('services/map_service_spec_sad_4',
    match_requests_on: %i[body]) do
      response = MapService.travel_time("", "")
      expect(response).to be(nil)
    end
  end
end