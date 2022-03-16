# frozen_string_literal: true

class SectionController < ApplicationController
  respond_to :json

  def index
    sections = Warehouse.find(params[:warehouse_id]).sections
    adaptive_area(sections)
    warehouse = Warehouse.find(params[:warehouse_id])
    render json: { sections: sections, warehouse: warehouse}, status: :ok
  end

  def adaptive_area(sections)
    area=0
    reserved_area = 0
    sections.each do |section|
      if section.active?
        area+=section.area.to_i
        reserved_area+=section.reserved.to_i
      end
    end
    Warehouse.find(params[:warehouse_id]).update(area: area, reserved: reserved_area)
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:id)
  end

end
