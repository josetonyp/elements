module Elements
  class ContentTranslation < Base
    belongs_to :workshop

    validates :locale, uniqueness: { scope: :elements_content_id, message: "should happen once per Content" }

    def locale_enum
      I18n.available_locales
    end

  end
end
