class MapService
  def self.lat_and_long(location)
    response = conn.get('geocoding/v1/address') do |req|
      req.params['location'] = location
      req.params['key'] = Figaro.env.key
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.travel_time(start_city, end_city)
    response = conn.get('directions/v2/route') do |req|
      req.params['from'] = start_city
      req.params['to'] = end_city
      req.params['key'] = Figaro.env.key
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:route][:formattedTime]
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com')
  end
end
