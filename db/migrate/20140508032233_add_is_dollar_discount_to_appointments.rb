class AddIsDollarDiscountToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :is_dollar_discount, :boolean
  end
end
