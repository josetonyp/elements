module Elements
  class Picture < Attachment
    ATTRIBUTES = [:name, :alt, :title, :copy_right, :creator, :custom_attributes, :html_class]

    mount_uploader :file, PictureUploader

    before_save :update_url, on: :create

    private

      def update_url
        self.file_url = self.file.file_url if self.file
      end
  end
end
