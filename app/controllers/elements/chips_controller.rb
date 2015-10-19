require_dependency "elements/application_controller"

module Elements
  class ChipsController < ApplicationController
    include Elements::Concerns::ChipActions

  end
end
