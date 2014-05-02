class AddPackagingHoursToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :packaging_hours, :integer
  end
end
