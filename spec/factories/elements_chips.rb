FactoryGirl.define do

  factory :chip, :class => 'Elements::Chip' do
    value "a value"
    sequence(:key, 1000) { |n| "key#{n}" }
  end

end
