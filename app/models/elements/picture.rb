module Elements
  class Picture < Attachment
    ATTRIBUTES = [:name, :alt, :title, :copy_right, :creator, :custom_attributes, :html_class]

    mount_uploader :file, PictureUploader


  end
end
