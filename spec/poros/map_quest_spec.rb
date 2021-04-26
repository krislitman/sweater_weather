require 'rails_helper'

RSpec.describe MapQuest do
  it 'Can be created with attributes' do
    file = File.read(Rails.root + 'spec/fixtures/mock_data/map_quest_poro.rb')
    attributes = JSON.parse(file, symbolize_names: true)
    expected = MapQuest.new(attributes)

    expect(expected).to be_an_instance_of(MapQuest)
    expect(expected.lat).to eq(39.738453)
    expect(expected.lng).to eq(-104.984853)
  end
end