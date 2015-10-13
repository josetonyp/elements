module Elements
  class ChipTranslation < ActiveRecord::Base
    belongs_to :chip

    validates :locale, uniqueness: { scope: :elements_chip_id, message: "should happen once per Chip" }

    def locale_enum
      I18n.available_locales
    end

  end
end
