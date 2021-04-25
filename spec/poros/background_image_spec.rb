require 'rails_helper'

RSpec.describe BackgroundImage do
  it "Can be made with attributes" do
    VCR.use_cassette('poros/background_image',
    match_requests_on: %i[body]) do
      facade = BackgroundsFacade.new('Denver,CO')
      image = facade.image
      expected = JSON.parse(image.to_json, symbolize_names: true)
    end
  end
end