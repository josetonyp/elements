module Elements
  class Chip < ActiveRecord::Base
    translates :value

    has_many :chip_translations
    accepts_nested_attributes_for :chip_translations

    belongs_to :parent, class_name: "Chip"
    has_many :children, class_name: "Chip", foreign_key: "parent_id"
    validates :key,
                presence: true,
                format: {
                  with: /\A[a-z_0-9]+?\z/,
                  message: "Must consist only of chars from 'a' to 'z'"
                  }

    before_save :add_name, on: :create

    rails_admin do
      label "Config Chip"
      edit do
        fields :key, :parent, :chip_translations
      end
      list do
        fields :key, :path
        field :format_translations
      end
    end

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

    def self.children
      self
    end


    def parent?
      parent.present?
    end

    def full_path
      (parent? ? "#{parent.full_path}." : "") << key
    end

    def add_name
      self.path = full_path
    end


    def self.by_paths
      all.inject({}) do |all, chip|
        all[chip.path] = chip.format_translations unless chip.children.any?
        all
      end
    end
  end
end
