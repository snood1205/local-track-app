# frozen_string_literal: true

class MenuItemsController < ApplicationController
  def show
    @menu_item = MenuItem.find_by(slug: params[:id])
    if @menu_item.nil?
      render json: { error: 'Menu item not found' }, status: :not_found
    else
      render json: @menu_item.as_json(only: %i[name description], methods: :price), status: :ok
    end
  end
end
