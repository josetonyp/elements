module Elements
  module ContentsHelper
    def elements_content(id, tag=:div, options={})
      element = Elements::Content.find(id)
      options.merge!({
        id: element.id,
        element: element.class.class_name,
        multiline: element.multiline.to_s,
        locale: I18n.locale
        })
      content_tag(tag, options) do |tag|
        element.value.html_safe
      end
    end
  end
end
