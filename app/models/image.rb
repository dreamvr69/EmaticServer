class Image
  include Mongoid::Document

  mount_uploader :image, ::Coach::PhotoUploader
end
