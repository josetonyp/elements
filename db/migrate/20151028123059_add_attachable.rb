class AddAttachable < ActiveRecord::Migration
  def change
    add_column :elements_attachments,  :attachable_id, :integer
    add_column :elements_attachments,  :attachable_type, :string
  end
end
