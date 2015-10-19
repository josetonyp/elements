class CreateElementsMenus < ActiveRecord::Migration
  def change
    create_table :elements_menus do |t|
      t.string :name
      t.string :label
      t.string :title
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
  end
end
