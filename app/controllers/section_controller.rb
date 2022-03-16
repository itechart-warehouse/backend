# frozen_string_literal: true

class SectionController < ApplicationController
  respond_to :json

  def index
    sections = Warehouse.find(params[:warehouse_id]).sections
    render json: { sections: sections, warehouse: Warehouse.find(params[:warehouse_id])}, status: :ok
  end

  def adaptive_area
    sections = Warehouse.find(params[:warehouse_id]).sections
    area=0
    sections.each do |section|
      if section.active?
        area+=section.area.to_i
      end
    end
    Warehouse.find(params[:warehouse_id]).update(area: area)
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:id)
  end

end
