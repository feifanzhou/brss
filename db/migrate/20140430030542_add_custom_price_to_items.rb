class AddCustomPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :custom_price, :integer
  end
end
