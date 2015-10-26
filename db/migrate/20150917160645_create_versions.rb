class CreateVersions < ActiveRecord::Migration

  # The largest text column available in all supported RDBMS is
  # 1024^3 - 1 bytes, roughly one gibibyte.  We specify a size
  # so that MySQL will use `longtext` instead of `text`.  Otherwise,
  # when serializing very large objects, `text` might not be big enough.
  TEXT_BYTES = 1_073_741_823

  def up
    create_table :elements_versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object,    :limit => TEXT_BYTES
      t.datetime :created_at
    end
    add_index :elements_versions, [:item_type, :item_id]

    create_table :elements_contents do |t|
      t.string :name
      t.text :value
      t.boolean :multiline, default: false
      t.integer :position
      t.integer :creator_id
      t.integer :updater_id
      t.string :path
      t.string :template
      t.integer :template_id
      t.text :title
      t.text :meta_title
      t.text :meta_description
      t.text :meta_keyword
      t.text :excerpt
      t.string :status
      t.string :publish_at
      t.string :content_type
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end

    add_index :elements_contents, [:content_type], name: 'elements_contents_content_type'
    add_index :elements_contents, [:path], unique: true, name: 'unique_elements_contents_path'
    add_index :elements_contents, [:status], name: 'elements_contents_status'
    add_index :elements_contents, [:publish_at], name: 'elements_contents_publish_at'

    Elements::Content.create_translation_table!({
      value: :text,
      title: :text,
      meta_title: :text,
      meta_description: :text,
      meta_keyword: :text,
      excerpt: :text
    })

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
      t.string :file_url
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps null: false
    end

    add_index :elements_attachments, [:file_url], name: 'elements_attachments_file_url'
    add_index :elements_attachments, [:attachment_type], name: 'elements_attachments_attachment_type'

    create_table :elements_chips do |t|
      t.text :value
      t.string :key
      t.string :path

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count

      t.timestamps null: false
    end

    add_index :elements_chips, [:path], unique: true, name: 'unique_elements_chips_attachment_path'

    Elements::Chip.create_translation_table!({
      value: :string
    })

    create_table :elements_menus do |t|
      t.string :name
      t.string :label
      t.string :title
      t.string :url
      t.string :target
      t.string :subtitle
      t.string :icon_class
      t.string :custom_attributes

      t.belongs_to :content
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count

      t.timestamps null: false
    end

    Elements::Menu.create_translation_table!({
      name: :string,
      label: :string,
      title: :string,
      subtitle: :string,
      icon_class: :string,
      custom_attributes: :string
    })

    Elements::Menu.create( name: "Home", path: '/')
  end

  def down
    drop_table :elements_versions
    drop_table :elements_contents
    drop_table :elements_content_translations
    drop_table :elements_attachments
    drop_table :elements_menus
    drop_table :elements_menu_translations
    drop_table :elements_chips
    drop_table :elements_chip_translations
  end
end
