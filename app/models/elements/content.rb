module Elements
  class Content < Base

    class Translation < Base
      belongs_to :content, class_name: 'Elements::Content'

      validates :locale, uniqueness: { scope: :elements_content_id, message: "should happen once per Content" }

      def locale_enum
        I18n.available_locales
      end

    end

    ATTRIBUTES = [:name, :value, :path, :multiline, :position, :creator_id, :updater_id, :title, :meta_title, :meta_description, :meta_keyword, :excerpt, :status, :publish_at, :latitude, :longitude]
    has_paper_trail class_name: 'Elements::Version'

    translates :value, :title, :meta_title, :meta_description, :meta_keyword, :excerpt
    self.inheritance_column = :content_type

    has_many :content_translations, class_name: 'Content::Translation', foreign_key: :elements_content_id
    accepts_nested_attributes_for :content_translations

    default_scope -> { includes(:content_translations) }
    scope :published, -> { where( 'publish_at < ?', DateTime.now ) }

    validates :name, presence: true
    validates :value, presence: true
    validates :path, presence: true, uniqueness: true

    before_destroy :validate_published


    def publish!
      self.publish_at = DateTime.now
      self.save
      self
    end

    private

      def validate_published
        raise "Elements::Content #{self.id} can't be delete as is published" unless self.publish_at.nil?
      end

  end
end
