class AddContentfulness < ActiveRecord::Migration
  def change
    add_column :elements_contents, :path, :text
    add_column :elements_contents, :title, :text
    add_column :elements_contents, :meta_title, :text
    add_column :elements_contents, :meta_description, :text
    add_column :elements_contents, :meta_keyword, :text
    add_column :elements_contents, :excerpt, :text
    add_column :elements_contents, :status, :string
    add_column :elements_contents, :publish_at, :string
    add_column :elements_contents, :content_type, :string

    add_column :elements_contents, :latitude, :string
    add_column :elements_contents, :longitude, :string

    add_column :elements_content_translations, :title, :text
    add_column :elements_content_translations, :meta_title, :text
    add_column :elements_content_translations, :meta_description, :text
    add_column :elements_content_translations, :meta_keyword, :text
    add_column :elements_content_translations, :excerpt, :text
    add_column :elements_content_translations, :content_type, :string
  end
end
