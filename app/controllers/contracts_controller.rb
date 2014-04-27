class ContractsController < ApplicationController
  def index
    render json: Contract.all.to_json
  end
end
