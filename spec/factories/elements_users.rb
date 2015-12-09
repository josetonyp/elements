FactoryGirl.define do
  factory :user, :class => 'Elements::User' do
    sequence(:name) {|n| "Name - #{n}"}
    sequence(:lastname) {|n| "Lastname - #{n}"}
    sequence(:email) {|n| "some#{n}@domain.com"}
    password "12345678"
  end

end
