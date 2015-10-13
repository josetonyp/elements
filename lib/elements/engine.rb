module Elements
  class Engine < ::Rails::Engine
    isolate_namespace Elements

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    initializer 'my_engine.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Elements::ContentsHelper
        helper Elements::ChipsHelper
        helper Elements::AttachmentsHelper
      end
    end

  end
end
