module Elements
  class Attachment < Base
    self.inheritance_column = :attachment_type

    ATTRIBUTES = [:name, :alt, :title, :copy_right, :creator, :custom_attributes, :html_class, :file]

    mount_uploader :file, FileUploader

    validates :file, presence: true

    def format_json
      {
        id: id,
        name: name,
        alt: alt,
        title: title,
        copy_right: copy_right,
        creator: creator,
        custom_attributes: custom_attributes,
        html_class: html_class
      }
    end

  end
end
