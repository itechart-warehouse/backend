# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_roles
  devise_for :users,
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords',
               confirmations: 'confirmations',
             }

  resources :companies ,controller: :company, only: %i[index show] do
    collection do
      post '/update/:id', to: 'company#update'
    end
    get '/warehouses', to: 'warehouse#index'
  end
  post 'company/create', to: 'company#create'
  get 'company/create', to: 'company#check_system_access'


  resources :users,controller: :user, only: :show do
    collection do
      post '/update/:id', to: 'user#update'
      get '', to: 'user#index'
    end
  end
  get 'user/create', to: 'user#company_and_roles_list'
  post 'user/create', to: 'user#create'

  get 'roles', to: 'user_roles#index'


  resources :warehouse, only: :show do
    collection do
      post '/create', to: 'warehouse#create'
    end
  end
  post 'warehouses/update/:id', to: 'warehouse#update'

  get 'reports/:report_id/goods', to: 'reports#show_reported'


  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  resources :consignment, path: "warehouse-consignments", only: %i[index show] do
    collection do
      post '/:id/check', to: 'consignment#check'
      post '/:id/place', to: 'consignment#place'
      get '/:id', to: 'consignment#show'
      get '', to: 'consignment#index'
      post '/:id/recheck', to: 'consignment#recheck'
      post '/:id/shipp', to: 'consignment#shipp'
    end
  end
  post 'consignments/create', to: 'consignment#create'

  scope 'warehouse-consignments' do
    get '/:id/goods', to: 'goods#index'
    get '/:id/reports/create', to: 'report_type#index'
    post '/:id/reports/create', to: 'reports#create'
    get '/:consignment_id/reports', to: 'reports#index_where_consigment_id'
  end
end
