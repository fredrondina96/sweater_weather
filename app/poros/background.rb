class Background

  attr_reader :id, :url

  def initialize(location)
    @id = nil
    @url = load_image(location)
  end

  def load_image(location)
    UnsplashService.new.load_image_url(location)
  end
end
