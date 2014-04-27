class ChangeTypeColumnNames < ActiveRecord::Migration
  def change
    rename_column :contracts, :type, :contract_type
    rename_column :appointments, :type, :appointment_type
    rename_column :items, :type, :item_type
  end
end
