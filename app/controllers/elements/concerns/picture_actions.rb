module Elements
  module Concerns
    module PictureActions
      extend ActiveSupport::Concern

      include AttachmentActions

      def content_class
        Picture
      end

    end
  end
end
