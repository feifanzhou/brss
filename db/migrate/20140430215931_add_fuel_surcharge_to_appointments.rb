class AddFuelSurchargeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :fuel_surcharge, :integer
  end
end
