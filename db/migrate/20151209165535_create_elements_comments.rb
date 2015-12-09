class CreateElementsComments < ActiveRecord::Migration
  def change
    create_table :elements_comments do |t|
      t.integer :content_id
      t.text :text
      t.integer :creator_id
      t.integer :updater_id
      t.timestamp :publish_at
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count

      t.timestamps null: false
    end
  end
end
