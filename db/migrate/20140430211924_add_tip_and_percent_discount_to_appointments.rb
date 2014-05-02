class AddTipAndPercentDiscountToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :tip, :integer
    add_column :appointments, :percent_discount, :integer
  end
end
