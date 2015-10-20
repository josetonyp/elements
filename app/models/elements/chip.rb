module Elements
  class Chip < Base
    ATTRIBUTES = [:key, :value, :parent_id]
    translates :value
    acts_as_nested_set

    has_many :chip_translations
    accepts_nested_attributes_for :chip_translations

    validates :key,
                presence: true,
                format: {
                  with: /\A[a-z_0-9]+?\z/,
                  message: "Must consist only of chars from 'a' to 'z'"
                  }

    before_save :add_full_path, on: :create

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
