class AddValueToItems < ActiveRecord::Migration
  def change
    add_column :items, :value, :integer
  end
end
