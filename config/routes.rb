# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dynamic_cart_line_items, only: :create
end
