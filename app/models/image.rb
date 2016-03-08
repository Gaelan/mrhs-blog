class Image < ActiveRecord::Base
  has_attached_file :file, preserve_files: true
  validates_attachment_content_type :file, content_type: %r{\Aimage\/.*\Z}
  belongs_to :post

  attr_reader :file_remote_url

  def file_remote_url=(url_value)
    self.file = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @file_remote_url = url_value
  end
end
