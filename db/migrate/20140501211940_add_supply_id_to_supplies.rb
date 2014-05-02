class AddSupplyIdToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :supply_id, :integer
  end
end
