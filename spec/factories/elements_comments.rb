FactoryGirl.define do
  factory :comment, :class => 'Elements::Comment' do
    text "Somen coment"
    content { FactoryGirl.create :user }
    creator { FactoryGirl.create :user }
  end

  factory :published_comment, parent: :comment do
    publish_at { DateTime.now - 1.day }
  end
end
