class CreateElementsChips < ActiveRecord::Migration
  def up
    create_table :elements_chips do |t|
      t.text :value
      t.string :key
      t.text :path

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count

      t.timestamps null: false
    end
    Elements::Chip.create_translation_table!({
      value: :string
    })
  end

  def down
    drop_table :elements_chips
    drop_table :elements_chip_translations
  end
end
