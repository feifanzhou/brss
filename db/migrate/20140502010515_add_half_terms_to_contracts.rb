class AddHalfTermsToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :half_terms, :integer
  end
end
