class AddPalletToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :pallet, :string
  end
end
