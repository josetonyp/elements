class AddTranslation < ActiveRecord::Migration
  def up
    Elements::Content.create_translation_table!({
      value: :string
    })
  end

  def down
    drop_table :elements_content_translations
  end
end
