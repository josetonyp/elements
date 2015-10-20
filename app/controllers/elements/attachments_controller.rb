require_dependency "elements/application_controller"

module Elements
  class AttachmentsController < ApplicationController
    include Elements::Concerns::AttachmentActions
  end
end
