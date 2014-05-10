class AddTotalsToAppointmentnts < ActiveRecord::Migration
  def change
    add_column :appointments, :app_items_total, :decimal
    add_column :appointments, :app_supplies_total, :decimal
    add_column :appointments, :app_insurance_total, :decimal
    add_column :appointments, :app_packing_total, :decimal
    add_column :appointments, :app_subtotal, :decimal
    add_column :appointments, :app_total_tax, :decimal
    add_column :appointments, :app_total_order, :decimal
    add_column :appointments, :app_total_final, :decimal
  end
end
