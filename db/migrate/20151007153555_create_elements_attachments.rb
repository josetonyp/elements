class CreateElementsAttachments < ActiveRecord::Migration
  def change
    create_table :elements_attachments do |t|
      t.string :name
      t.string :alt
      t.string :title
      t.string :copy_right
      t.string :creator
      t.string :custom_attributes
      t.string :html_class
      t.string :attachment_type

      t.string :file
      t.string :file_mime_type
      t.string :file_size
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps null: false
    end
  end
end
