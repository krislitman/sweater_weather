class MapService
  def self.lat_and_long(location)
    response = conn.get("geocoding/v1/address") do |req|
      req.params['location'] = location
      req.params['key'] = Figaro.env.key
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://www.mapquestapi.com')
  end
end
