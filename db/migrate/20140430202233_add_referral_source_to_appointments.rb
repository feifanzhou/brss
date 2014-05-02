class AddReferralSourceToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :referral_source, :string
  end
end
