# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Whitelist
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # process eager: true  # Force version generation at upload time.
  process convert: 'jpg'
  cloudinary_transformation width: 300, height: 300, gravity: :face, crop: :thumb # Resize on image upload

  version :avatar do
    cloudinary_transformation width: 200, height: 200, gravity: :face, crop: :thumb
    eager
  end
end
