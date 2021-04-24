class BackgroundsService
  def self.background_image(location, current_conditions = 'skyline')
    response = conn.get('services/rest') do |req|
      req.params['method'] = 'flickr.photos.search'
      req.params['per_page'] = '1'
      req.params['text'] = "#{location.split(',').join(' ')} #{current_conditions}"
      req.params['api_key'] = Figaro.env.api_key
      req.params['extras'] = 'owner_name'
      req.params['extras'] = 'url_c'
      req.params['format'] = 'json'
      req.params['nojsoncallback'] = '1'
    end
    data = JSON.parse(response.body, symbolize_names: true)
    return if data[:photos][:photo].empty?

    BackgroundImage.new(data, location)
  end

  def self.conn
    Faraday.new('https://api.flickr.com')
  end
end
