# frozen_string_literal: true

Rails.application.routes.draw do
  resource :tracks, only: [] do
    get 'info'
  end
end
