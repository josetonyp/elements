module Elements
  class Menu < Base

    attr_accessor :path

    translates :name, :label, :title, :subtitle, :icon_class, :custom_attributes

    ATTRIBUTES = [:name, :parent_id, :label, :title, :subtitle, :icon_class, :custom_attributes, :path, :url, :target]
    acts_as_nested_set

    belongs_to :content
    has_many :menu_translations, foreign_key: :elements_menu_id
    accepts_nested_attributes_for :menu_translations

    validates :name, presence: true

    before_save :create_content,  on: :create

    before_destroy :remove_content

    def format_json
      {
        id: id,
        name: name,
        parent_id: parent_id,
        depth: depth,
        label: label,
        title: title,
        subtitle: subtitle,
        icon_class: icon_class,
        custom_attributes: custom_attributes,
        href: href,
        target: target
      }
    end

    def content_path
      content.present? ? content.path : ""
    end

    def href
      self.url.nil? ? self.content_path : self.url
    end

    def full_path
      (self.parent.present? ? "/#{parent.content_path.gsub(/^\//, '')}/" : "") << (@path.present? ? @path : name.parameterize)
    end

    def update_path(new_path = nil)
      @path = new_path
      content.path = full_path.gsub('//', '/')
      content.save
      content.path
    end

    private
      def create_content
        self.content = Page.create( name: self.name, value: self.name, path: full_path.gsub('//', '/') ) if self.content_id.nil?
      end

      def remove_content
        self.content.destroy if self.content.present?
      end

  end
end
