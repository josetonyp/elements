FactoryGirl.define do

  factory :menu_item, :class => 'Elements::Menu' do
    sequence(:name, 1000) { |n| "Page #{n}" }
    content
    label "Menu Label"
    title "Menu Title"
    subtitle "Menu Subtitle"
    icon_class "icon-class"
    custom_attributes 'sytle="color:red;"'
  end

end
