require 'rails_helper'

RSpec.describe BackgroundsService do
  it 'Returns Image data from Flickr' do
    VCR.use_cassette('services/backgrounds_service_spec',
    match_requests_on: %i[body]) do
      response = BackgroundsService.background_image('Tampa,FL')

      expect(response).to be_an_instance_of(BackgroundImage)
      expect(response.location).to eq('Tampa,FL')
      expect(response.credit[:source]).to eq('flickr.com')
    end
  end
  it 'Returns Image data from Flickr with extra text' do
    VCR.use_cassette('services/backgrounds_service_spec_2',
    match_requests_on: %i[body]) do
      response = BackgroundsService.background_image('Tampa,FL', 'night cloudy')
      
      expect(response).to be_an_instance_of(BackgroundImage)
      expect(response.location).to eq('Tampa,FL')
      expect(response.credit[:source]).to eq('flickr.com')
    end
  end
end