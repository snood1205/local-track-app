# frozen_string_literal: true

class VendorsController < ApplicationController
  def index
    @vendors = Vendor.select(:id, :name, :category)
    render json: @vendors
  end

  def grouped
    @grouped_vendors = Vendor.select(:id, :name, :category)
                             .group_by(&:category)
                             .transform_values! { |vendors| vendors.map { |vendor| vendor.as_json(only: %i[id name]) } }
    render json: @grouped_vendors
  end
end
