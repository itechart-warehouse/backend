# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_roles
  devise_for :users,
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords',
               confirmations: 'confirmations'
             }

  get 'company/create', to: 'company#check_system_access'
  post 'company/create', to: 'company#create'
  resources :companies, controller: :company, only: %i[show index] do
    collection do
      post '/update/:id', to: 'company#update'
    end
    get '/warehouses', to: 'warehouse#index'
  end

  get 'user/create', to: 'user#company_and_roles_list'
  post 'user/create', to: 'user#create'
  get 'user/:id', to: 'user#show'
  resources :users, controller: :user, only: :index do
    collection do
      post '/update/:id', to: 'user#update'
    end
  end

  resources :warehouse, only: :show do
    collection do
      post '/create', to: 'warehouse#create'
    end
  end
  post 'warehouses/update/:id', to: 'warehouse#update'

  get 'reports/:report_id/goods', to: 'reports#show_reported'

  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  resources :consignment, path: 'warehouse-consignments', only: %i[show index] do
    collection do
      post '/:id/check', to: 'consignment#check'
      post '/:id/place', to: 'consignment#place'
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

  get 'user_roles/:id/users', to: 'user_roles#users_by_role'
end
