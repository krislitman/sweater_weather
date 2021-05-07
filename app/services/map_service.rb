class MapService
  def self.lat_and_long(location)
    return nil if location.to_s == location.to_i.to_s 
    response = conn.get('geocoding/v1/address') do |req|
      req.params['location'] = location
      req.params['key'] = Figaro.env.key
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.travel_time(start_city, end_city)
    return nil if (start_city.to_s == start_city.to_i.to_s) ||
    (end_city.to_s == end_city.to_i.to_s) 
    response = conn.get('directions/v2/route') do |req|
      req.params['from'] = start_city
      req.params['to'] = end_city
      req.params['key'] = Figaro.env.key
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:route][:formattedTime]
  end

  private

  def self.conn
    Faraday.new('http://www.open.mapquestapi.com')
  end
end
