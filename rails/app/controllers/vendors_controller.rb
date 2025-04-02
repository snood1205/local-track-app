# frozen_string_literal: true

class VendorsController < ApplicationController
  def index
    @vendors = Vendor.all
    render json: @vendors.as_json(only: %i[id name category])
  end

  def grouped
  end
end
