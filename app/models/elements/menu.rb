module Elements
  class Menu < Base
    ATTRIBUTES = [:name, :parent_id, :label, :title, :subtitle, :icon_class, :custom_attributes]
    acts_as_nested_set

    belongs_to :content

    validates :name, presence: true

    before_save :create_content,  on: :create

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
        custom_attributes: custom_attributes
      }
    end

    private
      def create_content
        self.content = Page.create( name: self.name, value: self.name ) if self.content_id.nil?
      end

  end
end
