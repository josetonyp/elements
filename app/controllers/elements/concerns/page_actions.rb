module Elements
  module Concerns
    module PageActions
      extend ActiveSupport::Concern

      include ContentActions

      def content_class
        Page
      end

    end
  end
end
