class CreateElementsContents < ActiveRecord::Migration
  def change
    create_table :elements_contents do |t|
      t.string :name
      t.text :value
      t.boolean :multiline, default: false
      t.integer :position
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps null: false
    end
  end
end
