class AddFieldRepNameToProvisions < ActiveRecord::Migration
  def change
    add_column :provisions, :rep_name, :string
  end
end
