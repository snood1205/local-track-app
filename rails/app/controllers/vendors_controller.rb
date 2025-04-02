# frozen_string_literal: true

class VendorsController < ApplicationController
  before_action :set_collection_select, only: %i[index grouped]
  before_action :set_collection_all, only: %i[grouped_with_menu]

  def index
    render json: @vendors.as_json(only: %i[name category slug])
  end

  def grouped
    render json: grouped_vendors
  end

  def grouped_with_menu
    render json: grouped_vendors(%i[menu])
  end

  private

  def grouped_vendors(methods = [])
    @vendors.group_by(&:category)
            .transform_values { |vendors| vendors.map { |vendor| vendor.as_json(only: %i[name slug], methods:) } }
  end

  def set_collection_select
    @vendors = Vendor.select(:name, :category, :slug)
  end

  def set_collection_all
    @vendors = Vendor.all
  end
end
