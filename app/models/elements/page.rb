module Elements
  class Page < Content

    has_one :menu, foreign_key: "content_id"
  end
end
