module Elements
  class Engine < ::Rails::Engine
    isolate_namespace Elements

    config.generators do |g|
      g.test_framework :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
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
