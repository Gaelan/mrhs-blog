class Image < ActiveRecord::Base
  has_attached_file :file, preserve_files: true
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  belongs_to :post
end
