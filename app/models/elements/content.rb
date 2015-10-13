require 'redcarpet'
module Elements
  class Content < ActiveRecord::Base
    translates :value

    has_many :content_translations
    accepts_nested_attributes_for :content_translations

    validates :name, presence: true
    validates :value, presence: true

    def marked
      renderer.render(self.value || '')
    end

    private

      def renderer
        @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
      end
  end
end
