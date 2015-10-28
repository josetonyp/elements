module Elements
  class Attachment < Base
    self.inheritance_column = :attachment_type

    ATTRIBUTES = [:name, :alt, :title, :copy_right, :creator, :custom_attributes, :html_class, :file]

    mount_uploader :file, FileUploader

    validates :file, presence: true

    belongs_to :attachable, polymorphic: true

    def format_json
      out = {
        id: id,
        name: name,
        alt: alt,
        title: title,
        copy_right: copy_right,
        creator: creator,
        custom_attributes: custom_attributes,
        html_class: html_class,
        url: file.url,
        size: file_size,
        mime_type: file_mime_type,
      }
      out[:content] = attachable.id if attachable
      out
    end

  end
end
