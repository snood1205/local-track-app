# frozen_string_literal: true

class VendorsController < ApplicationController
  before_action :set_vendors, only: %i[index grouped]

  def index
    render json: @vendors.as_json(only: %i[name category slug])
  end

  def grouped
    grouped_vendors =
      @vendors.group_by(&:category)
              .transform_values { |vendors| vendors.map { |vendor| vendor.as_json(only: %i[name slug]) } }
    render json: grouped_vendors
  end

  private

  def set_vendors
    @vendors = Vendor.select(:name, :category, :slug)
  end
end
