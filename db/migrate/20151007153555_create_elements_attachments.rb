class CreateElementsAttachments < ActiveRecord::Migration
  def change
    create_table :elements_attachments do |t|
      t.string :name
      t.string :file_name
      t.string :file_mime_type
      t.string :file_size
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps null: false
    end
  end
end
