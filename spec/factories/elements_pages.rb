FactoryGirl.define do
  factory :page, :class => 'Elements::Page' do
    sequence(:name, 1000) { |n| "Element Page #{n}" }
    value "Element Page"
    creator_id "Element Page"
    updater_id "Element Page"
    sequence(:path, 1000) { |n| "element-page-path-#{n}" }
    title "Some title"
    meta_title "Element Page"
    meta_description "Element Page"
    meta_keyword "Element Page"
    excerpt "Element Page"
    status 'new'
    #Berlin
    latitude 52.520645.to_s
    longitude 13.409779.to_s
  end

  factory :published_page, parent: :page do
    publish_at { DateTime.now - 1.day }
  end

  factory :future_page, parent: :page do
    publish_at { DateTime.now + 1.day }
  end

end
