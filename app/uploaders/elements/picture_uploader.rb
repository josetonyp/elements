# encoding: utf-8
module CarrierWave
  module MiniMagick
    # Rotates the image based on the EXIF Orientation
    # According to http://jpegclub.org/exif_orientation.html
    def auto_orient
      manipulate! do |image|
        case image['EXIF:Orientation'].to_i
        when 2
          image.flop
        when 3
          image.rotate(180)
        when 4
          image.flip
        when 5
          image.transpose
        when 6
          image.rotate(90)
        when 7
          image.transverse
        when 8
          image.rotate(270)
        end

        image
      end
    end
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
module Elements
  class PictureUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    include CarrierWave::MiniMagick
    include CarrierWave::MimeTypes
    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}"
    end

    def filename
      if original_filename
        @name ||= "#{model.id}#{Digest::MD5.hexdigest(File.dirname(current_path))}"
        "#{@name}.#{file.extension.downcase}"
      end
    end

    def file_url
      "/uploads/#{model.class.to_s.underscore}/#{@name}.#{file.extension.downcase}"
    end

    process :fix_exif_rotation
    process :set_content_type
    process :save_content_type_and_size_in_model

    def save_content_type_and_size_in_model
      model.file_mime_type = file.content_type if model.respond_to?(:file_mime_type) && file.content_type
      model.file_size = file.size if model.respond_to?(:file_size)
    end

    def extension_white_list
      %w(jpg jpeg png)
    end


    def fix_exif_rotation #this is my attempted solution
      manipulate! do |img|
        img.tap(&:auto_orient)
      end
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    # Scaled the image to a max of 800 px wide and any height
    # process :resize_to_limit => [800, -1]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :resize_to_fit => [50, 50]
    # end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    # def extension_white_list
    #   %w(jpg jpeg gif png)
    # end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

  end
end
