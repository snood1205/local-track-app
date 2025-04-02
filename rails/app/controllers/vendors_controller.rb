# frozen_string_literal: true

class VendorsController < ApplicationController
  def index
    @vendors = Vendor.select(:name, :category)
    render json: @vendors.as_json(only: %i[name category])
  end

  def grouped
    @grouped_vendors = Vendor.select(:name, :category)
                             .group_by(&:category)
                             .transform_values! { |vendors| vendors.map { |vendor| vendor.as_json(only: %i[name]) } }
    render json: @grouped_vendors
  end
end
