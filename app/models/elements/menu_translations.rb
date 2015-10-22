module Elements
  class MenuTranslation < Base
    belongs_to :menu, class_name: 'Elements::Menu'

    validates :locale, uniqueness: { scope: :elements_menu_id, message: "should happen once per Menu" }

    def locale_enum
      I18n.available_locales
    end

  end
end
