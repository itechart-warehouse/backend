# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { resource: resource, company: resource.company, warehouse: resource.warehouse_id ? Warehouse.find(resource.warehouse_id) : '', role: UserRole.find(resource.user_role_id)} 
  end

  def respond_to_on_destroy
    head :no_content
  end
end
