require 'rails_helper'
require 'time'
require 'timecop'

RSpec.describe BackgroundsFacade do
  it "Can be created with an image returned" do
    VCR.use_cassette('facades/backgrounds_facade/create',
    match_requests_on: %i[body]) do
      expected = BackgroundsFacade.new('Tampa,FL')
      response = JSON.parse(expected.to_json, symbolize_names: true)
      
      expect(expected).to be_an_instance_of(BackgroundsFacade)
      expect(expected.location).to eq('Tampa,FL')
      expect(expected.image).to be_an_instance_of(BackgroundImage)
      expect(response.keys).to include(:location)
      expect(response.keys).to include(:image)
      expect(response[:image].keys).to include(:image_url)
      expect(response[:image].keys).to include(:location)
      expect(response[:image].keys).to include(:credit)
      expect(response[:image][:credit].keys).to include(:source)
      expect(response[:image][:credit].keys).to include(:owner)

      expect(response.keys).not_to include(:current_weather)
      expect(response.keys).not_to include(:daily_weather)
      expect(response.keys).not_to include(:hourly_weather)
    end
  end
  it "Can get the time of day" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day',
    match_requests_on: %i[body]) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("09 00 PM")
        expected = BackgroundsFacade.new('Tampa,FL')
        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("evening")
    end
  end
  it "Can get the time of day 2" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_2',
    match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("07 00 PM")
        expected = BackgroundsFacade.new('London,UK')

        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("evening")
      end
    end
  end
  it "Can get the time of day 3" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_3',
    match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("05 00 PM")
        expected = BackgroundsFacade.new('Tampa,FL')

        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("afternoon")
      end
    end
  end
  it "Can get the time of day 4" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_4',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("07 00 AM")
        expected = BackgroundsFacade.new('Tampa,FL')
        
        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("morning")
      end
    end
  end
  it "Can get the time of day 5" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_5',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("12 00 PM")
        expected = BackgroundsFacade.new('Tampa,FL')

        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("morning")
      end
    end
  end
  it "Can get the time of day 6" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_6',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("03 00 AM")
        expected = BackgroundsFacade.new('Tampa,FL')

        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("night")
      end
    end
  end
  it "Can get the time of day 7" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_7',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("12 00 AM")
        expected = BackgroundsFacade.new('Tampa,FL')

        expect(expected.time_of_day).to be_a(String)
        expect(expected.time_of_day).to include("night")
      end
    end
  end
  it "Sad Path ~ Does not work without proper location" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_sad_1',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("12 00 AM")
        expected = BackgroundsFacade.new('12345')
        
        expect(expected.image).to be(nil)
      end
    end
  end
  it "Sad Path ~ Does not work without proper location 2" do
    VCR.use_cassette('facades/backgrounds_facade/time_of_day_sad_2',
      match_requests_on: %i[body]) do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        allow_any_instance_of(BackgroundsFacade).to receive(:find_time).and_return("12 00 AM")
        expected = BackgroundsFacade.new('')
        
        expect(expected.image).to be(nil)
      end
    end
  end
end