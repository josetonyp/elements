module Elements
  class Menu < Base

    class Translation < Base
      belongs_to :menu, class_name: 'Elements::Menu'

      validates :locale, uniqueness: { scope: :elements_menu_id, message: "should happen once per Menu" }

      def locale_enum
        I18n.available_locales
      end
    end

    attr_accessor :path

    translates :name, :label, :title, :subtitle, :icon_class, :custom_attributes

    ATTRIBUTES = [:name, :parent_id, :label, :title, :subtitle, :icon_class, :custom_attributes, :path, :url, :target]
    acts_as_nested_set

    belongs_to :creator, class_name: User
    belongs_to :updator, class_name: User

    belongs_to :page, foreign_key: "content_id"
    has_many :menu_translations, class_name: 'Menu::Translation', foreign_key: :elements_menu_id
    accepts_nested_attributes_for :menu_translations

    validates :name, presence: true

    before_save :create_page,  on: :create

    before_destroy :check_for_root
    before_destroy :remove_page

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

    def page_path
      page.present? ? page.path : ""
    end

    def href
      self.url.nil? ? self.page_path : self.url
    end

    def full_path
      (self.parent.present? ? "/#{parent.page_path.gsub(/^\//, '')}/" : "") << (@path.present? ? @path : name.parameterize)
    end

    def hierarchy_name
      "#{self.parent.present? ? "#{parent.hierarchy_name} -> " : "" }#{name}"
    end

    def update_path(new_path = nil)
      @path = new_path
      page.path = full_path.gsub('//', '/')
      page.save
      page.path
    end

    private
      def create_page
        self.page = Page.create( name: self.name, value: self.name, path: full_path.gsub('//', '/') ) if self.content_id.nil?
      end

      def remove_page
        self.page.destroy if self.page.present?
      end

      def check_for_root
        raise "Can't remove the root" if path == '/' and root?
      end

  end
end
