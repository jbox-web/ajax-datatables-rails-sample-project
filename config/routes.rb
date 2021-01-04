Rails.application.routes.draw do

  resources :transactions
  concern :with_datatable do
    post 'datatable', on: :collection
  end

  concern :with_selection do
    post 'select_all', on: :collection
    post 'reset_selection', on: :collection
  end

  root 'welcome#index'

  get 'both', to: 'welcome#both', as: 'both'

  resources :cities,       concerns: [:with_datatable, :with_selection]
  resources :countries,    concerns: [:with_datatable, :with_selection]
  resources :posts,        concerns: [:with_datatable, :with_selection]
  resources :users,        concerns: [:with_datatable, :with_selection]
  resources :transactions, concerns: [:with_datatable, :with_selection]
end
