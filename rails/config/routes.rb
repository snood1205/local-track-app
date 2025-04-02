# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tracks, only: [] do
    get 'info', on: :collection
  end

  resources :vendors, only: %i[index] do
    get 'grouped', on: :collection
    get 'grouped/include-menu', on: :collection, to: 'vendors#grouped_with_menu'
  end
end
