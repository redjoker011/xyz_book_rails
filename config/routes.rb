# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'books#index'
  get '/:id', to: 'books#show'

  scope path: 'api/v1/books', module: 'api/v1', as: :v1 do
    get ':id', to: 'books#book'
    get ':id/convert-isbn', to: 'books#convert_isbn'
  end
end
