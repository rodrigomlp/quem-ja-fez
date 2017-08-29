# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'


  version :avatar do
    cloudinary_transformation width: 200, height: 200, gravity: :face, crop: :thumb
  end
end
