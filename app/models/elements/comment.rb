module Elements
  class Comment < Base
    ATTRIBUTES = [:text, :parent_id, :creator_id, :updater_id]
    acts_as_nested_set

    belongs_to :content

    validates :content, presence: true
    validates :text, presence: true

    belongs_to :creator, class_name: User
    belongs_to :updator, class_name: User

    scope :published, -> { where( 'publish_at < ?', DateTime.now ) }


    def json_format
      {
        id: id,
        text: text,
        published: published?
      }
    end

    def publish!
      self.publish_at = DateTime.now
      save!
      self
    end

    def published?
      !publish_at.nil? && publish_at < DateTime.now
    end

  end
end
