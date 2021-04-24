require 'rails_helper'

RSpec.describe BackgroundsFacade do
  it "Can be created with an image returned" do
    VCR.use_cassette('facades/backgrounds_facade/create',
    match_requests_on: %i[body]) do
      expected = BackgroundsFacade.new('Tampa,FL')
      
      expect(expected).to be_an_instance_of(BackgroundsFacade)
      expect(expected.location).to eq('Tampa,FL')
      expect(expected.image).to be_an_instance_of(BackgroundImage)
    end
  end
  it "Can get the time of day" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day',
    match_requests_on: %i[body]) do
      expected = BackgroundsFacade.new('Tampa,FL')

      expect(expected.get_time_of_day).to eq('afternoon broken clouds')
    end
  end
end