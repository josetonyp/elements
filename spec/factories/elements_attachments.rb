FactoryGirl.define do
  factory :attachment, :class => 'Elements::Attachment' do
    name "MyString"
    alt "Some Attachment Info"
    title "Some Attachment Info"
    copy_right "Some Attachment Info"
    creator "Some Attachment Info"
    custom_attributes "Some Attachment Info"
    html_class "Some Attachment Info"
    file { Rack::Test::UploadedFile.new(File.join('spec', 'attachments', 'SamplePDF.pdf')) }
  end
  factory :picture, :class => 'Elements::Picture' do
    name "MyString"
    alt "Some Attachment Info"
    title "Some Attachment Info"
    copy_right "Some Attachment Info"
    creator "Some Attachment Info"
    custom_attributes "Some Attachment Info"
    html_class "Some Attachment Info"
    file { Rack::Test::UploadedFile.new(File.join('spec', 'attachments', 'signal.png')) }
  end
end
