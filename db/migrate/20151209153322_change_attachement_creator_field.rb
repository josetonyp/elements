class ChangeAttachementCreatorField < ActiveRecord::Migration
  def change
    remove_column :elements_attachments, :creator, :integer
    add_column :elements_attachments, :author, :integer
  end
end
