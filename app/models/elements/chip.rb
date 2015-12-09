module Elements
  class Chip < Base

    class Translation < Base
      belongs_to :chip, class_name: 'Elements::Chip'

      validates :locale, uniqueness: { scope: :elements_chip_id, message: "should happen once per Chip" }

      def locale_enum
        I18n.available_locales
      end

    end

    ATTRIBUTES = [:key, :value, :parent_id]
    translates :value
    acts_as_nested_set

    has_many :chip_translations, class_name: 'Chip::Translation'
    accepts_nested_attributes_for :chip_translations

    validates :key,
                presence: true,
                format: {
                  with: /\A[a-z_0-9]+?\z/,
                  message: "Must consist only of chars from 'a' to 'z'"
                  }

    before_save :add_full_path, on: :create

    belongs_to :creator, class_name: User
    belongs_to :updator, class_name: User

    def name
      path
    end

    def format_translations
      translations_by_locale.inject(translations_by_locale) do |acc,(locale,translation)|
        acc[locale] = translation.attributes['value']
        acc
      end
    end

    def format_json
      chip = {
        id: id,
        key: key,
        path: path
      }
      if children.any?
        chip.merge!({children: children.map(&:format_json)})
      else
        chip.merge!({locales: format_translations})
      end
      chip
    end

    def full_path
      (self.parent.present? ? "#{parent.full_path}." : "") << key
    end

    def add_full_path
      self.path = full_path
    end

  end
end
