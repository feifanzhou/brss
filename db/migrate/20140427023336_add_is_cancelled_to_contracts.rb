class AddIsCancelledToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :is_cancelled, :boolean
  end
end
