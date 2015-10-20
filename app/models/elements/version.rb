module Elements
  class Version < Base
    include PaperTrail::VersionConcern
    self.table_name = :elements_versions
  end
end
