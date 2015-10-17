module Elements
  class Menu < ActiveRecord::Base
    acts_as_nested_set
  end
end
