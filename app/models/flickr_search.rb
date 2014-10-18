class FlickrSearch
  def self.get_photos(place)
    new_b = flickr.places.find :query => place
    latitude = new_b[0]['latitude'].to_f
    longitude = new_b[0]['longitude'].to_f

    # within 60 miles of *place*, let's use a bbox
    radius = 1
    args = {}
    args[:bbox] = "#{longitude - radius},#{latitude - radius},#{longitude + radius},#{latitude + radius}"

    # requires a limiting factor, so let's give it one
    #args[:min_taken_date] = '1890-01-01 00:00:00'
    #args[:max_taken_date] = '1920-01-01 00:00:00'
    args[:accuracy] = 1 # the default is street only granularity [16], which most images aren't...
    discovered_pictures = flickr.photos.search args
    discovered_pictures.collect { |photo| FlickRaw.url(photo) }
  end
end
