FactoryGirl.define do
  factory :page, :class => 'Elements::Page' do
    name "Element Page"
    value "Element Page"
    creator_id "Element Page"
    updater_id "Element Page"
    path "element-content"
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
