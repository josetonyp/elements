module Elements
  class Chip < ActiveRecord::Base
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

    before_save :add_name, on: :create

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
      (parent? ? "#{parent.full_path}." : "") << key
    end

    def add_name
      self.path = full_path
    end

  end
end
