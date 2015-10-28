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

    has_many :attachments, as: :attachable

    def publish!
      self.publish_at = DateTime.now
      self.save
      self
    end


    def field_with_version(field)
      {
        id: id,
        created_at: created_at,
        :"#{field}" => self.send(field)
      }
    end

    def json_format_versions
      reload
      first,*rest = *versions
      first_version = {
          version: versions.count,
          version_created_at: first.created_at,
          content: first.item.json_format
        }
      rest.reverse.inject([first_version]) do |all, version|
        all << {
          version: version.index,
          version_created_at: version.created_at,
          content: version.reify.json_format
        }
      end
    end

    def json_format_field_versions(field)
      reload
      first,*rest = *versions
      first_version = {
          version: versions.count,
          version_created_at: first.created_at,
          :"#{field}" => first.item.send(field)
        }
      rest.reverse.inject([first_version]) do |all, version|
        all << {
          version: version.index,
          version_created_at: version.created_at,
          :"#{field}" => version.reify.send(field)
        }
      end
    end

    def json_format
      {
        id: id,
        name: name,
        value: value,
        path: path,
        multiline: multiline,
        position: position,
        title: title,
        meta_title: meta_title,
        meta_description: meta_description,
        meta_keyword: meta_keyword,
        excerpt: excerpt,
        status: status,
        publish_at: publish_at,
        latitude: latitude,
        longitude: longitude,
        versions: versions.count
      }
    end

    private

      def validate_published
        raise "Elements::Content #{self.id} can't be delete as is published" unless self.publish_at.nil?
      end

  end
end
