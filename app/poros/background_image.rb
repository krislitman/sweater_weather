class BackgroundImage
  attr_reader :location,
              :image_url,
              :credit

  def initialize(data, location)
    @location = location
    @image_url = data[:photos][:photo][0][:url_c]
    @credit = provide_credit(data)
  end

  def provide_credit(data)
    {
      source: "flickr.com",
      owner: data[:photos][:photo][0][:owner]
    }
  end
end