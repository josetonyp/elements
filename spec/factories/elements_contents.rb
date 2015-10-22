FactoryGirl.define do

  factory :content, :class => 'Elements::Content' do
    sequence(:name, 1000) { |n| "Element Content #{n}" }
    value "Element Content"
    creator_id "Element Content"
    updater_id "Element Content"
    sequence(:path, 1000) { |n| "element-content-path-#{n}" }
    title "Some title"
    meta_title "Element Content"
    meta_description "Element Content"
    meta_keyword "Element Content"
    excerpt "Element Content"
    status 'new'
    #Berlin
    latitude 52.520645.to_s
    longitude 13.409779.to_s
  end

  factory :published_content, parent: :content do
    publish_at { DateTime.now - 1.day }
  end

  factory :future_content, parent: :content do
    publish_at { DateTime.now + 1.day }
  end

end
