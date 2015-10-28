module Elements
  module Concerns
    module GalleryActions
      extend ActiveSupport::Concern

      include ContentActions

      def content_class
        Gallery
      end

    end
  end
end
