class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :elements_users, :published, :timestamp
    add_column :elements_users, :title, :string
    add_column :elements_users, :display_name, :string
    add_column :elements_users, :resume, :text
    add_column :elements_users, :picture, :string
    add_column :elements_users, :avatar, :string
    add_column :elements_users, :name, :string
    add_column :elements_users, :lastname, :string

  end
end
