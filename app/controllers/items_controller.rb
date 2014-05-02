class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Item.create(item_params)
    render json: {
      success: 1,
      errors: []
    }
  end

  def update
    item = Item.find(params[:id])
    if item.blank?
      render json: {
        success: 0,
        errors: ['No item found']
      }
    else
      item.update!(item_params)
      render json: {
        success: 1,
        errors: []
      }
    end
  end

  def destroy
    i = Item.find(params[:id])
    i.is_deleted = true
    i.save
    render json: {
      success: 1,
      errors: []
    }
  end

  private
  def item_params
    params.require(:item).permit(:contract_id, :item_type, :description, :notes, :weight, :quantity, :is_deleted, :custom_price, :should_insure, :value)
  end
end
