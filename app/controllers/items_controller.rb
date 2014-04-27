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
    if appt.blank?
      render json: {
        success: 0,
        errors: ['No item found']
      }
    else
      appt.update!(item_params)
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
  end

  private
  def item_params
    params.require(:item).permit(:contract_id, :item_type, :description, :notes, :weight)
  end
end
