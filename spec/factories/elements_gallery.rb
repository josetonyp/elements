FactoryGirl.define do
  factory :gallery, :class => 'Elements::Gallery' do
    sequence(:name, 1000) { |n| "Element Gallery #{n}" }
    value "Element Gallery"
    creator_id "Element Gallery"
    updater_id "Element Gallery"
    sequence(:path, 1000) { |n| "element-gallery-path-#{n}" }
    title "Some title"
    meta_title "Element Gallery"
    meta_description "Element Gallery"
    meta_keyword "Element Gallery"
    excerpt "Element Gallery"
    status 'new'
    #Berlin
    latitude 52.520645.to_s
    longitude 13.409779.to_s
  end

  factory :published_gallery, parent: :gallery do
    publish_at { DateTime.now - 1.day }
  end

  factory :future_gallery, parent: :gallery do
    publish_at { DateTime.now + 1.day }
  end

end
