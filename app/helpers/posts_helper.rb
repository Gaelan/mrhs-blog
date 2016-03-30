module PostsHelper
  # require 'mini_exiftool'

  def image_exif(image)
    exif = MiniExiftool.new image.file.path
    # binding.pry
    info = {
      aperture: exif.aperturevalue,
      datetimeoriginal: exif.datetimeoriginal,
      flash: exif.flash,
      iso: exif.iso,
      make: exif.make,
      model: exif.model,
      shutterspeed: exif.shutterspeed,
    }
    @camera = "#{exif.make} #{exif.model}, #{exif.lensinfo}"
    @exposure = "#{exif.shutterspeed.to_s} f/#{exif.aperturevalue} ISO: #{exif.iso}"
    @capture = "#{exif.datetimeoriginal} #{exif.imagesize}"
    binding.pry
    exif
  end
end
