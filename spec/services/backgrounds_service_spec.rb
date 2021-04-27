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
  it 'Sad Path ~ Does not return image with poor request' do
    VCR.use_cassette('services/backgrounds_service_spec_3',
    match_requests_on: %i[body]) do
      image = BackgroundsService.background_image(1235)
      
      expect(image).to be(nil)
    end
  end
  it 'Sad Path ~ Does not return image with poor request 2' do
    VCR.use_cassette('services/backgrounds_service_spec_4',
    match_requests_on: %i[body]) do
      image = BackgroundsService.background_image("NONONONONONO!")
      
      expect(image).to be(nil)
    end
  end
  it 'Sad Path ~ Does not return image with poor request 3' do
    VCR.use_cassette('services/backgrounds_service_spec_4',
    match_requests_on: %i[body]) do
      image = BackgroundsService.background_image("")
      
      expect(image).to be(nil)
    end
  end
end