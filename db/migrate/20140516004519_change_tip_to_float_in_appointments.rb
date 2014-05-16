class ChangeTipToFloatInAppointments < ActiveRecord::Migration
  def up
    change_column :appointments, :tip, :decimal
  end
  def down
    change_column :appointments, :tip, :integer
  end
end
