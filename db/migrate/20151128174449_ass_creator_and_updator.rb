class AssCreatorAndUpdator < ActiveRecord::Migration
  def change
    add_column :elements_chips, :creator_id, :integer
    add_column :elements_menus, :creator_id, :integer
    add_column :elements_users, :creator_id, :integer

    add_column :elements_chips, :updater_id, :integer
    add_column :elements_menus, :updater_id, :integer
    add_column :elements_users, :updater_id, :integer
  end
end
