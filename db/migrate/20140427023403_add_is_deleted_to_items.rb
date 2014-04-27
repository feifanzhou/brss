class AddIsDeletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :is_deleted, :boolean
  end
end
