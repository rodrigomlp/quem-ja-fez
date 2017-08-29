# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :avatar_md do
    cloudinary_transformation width: 100, height: 100, gravity: :face, crop: :thumb
  end
end
