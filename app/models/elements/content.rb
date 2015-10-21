module Elements
  class Content < Base
    has_paper_trail class_name: 'Elements::Version'

    translates :value, :title, :meta_title, :meta_description, :meta_keyword, :excerpt
    self.inheritance_column = :content_type

    has_many :content_translations, foreign_key: :elements_content_id
    accepts_nested_attributes_for :content_translations

    default_scope -> { includes(:content_translations) }
    scope :published, -> { where( 'publish_at < ?', DateTime.now ) }

    validates :name, presence: true
    validates :value, presence: true

  end
end
