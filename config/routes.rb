# frozen_string_literal: true

Rails.application.routes.draw do
  scope path: 'api/v1/books', module: 'api/v1', as: :v1 do
    get ':id', to: 'books#book'
  end
end
