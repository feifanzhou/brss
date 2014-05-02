class AddShouldInsureToItems < ActiveRecord::Migration
  def change
    add_column :items, :should_insure, :boolean
  end
end
