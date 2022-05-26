# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_roles
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  resources :companies ,controller: :company, only: :show do
    collection do
      post '/update/:id', to: 'company#update'
    end
    get '/warehouses/(:page)/(:perPage)', to: 'warehouse#index'
  end
  post 'company/create', to: 'company#create'
  get 'company/create', to: 'company#check_system_access'
  get 'company/(:page)/(:perPage)',to: 'company#index'

  resources :users,controller: :user, only: nil do
    collection do
      get '/(:page)/(:perPage)',to: 'user#index'
      post '/update/:id', to: 'user#update'
    end

  end
  get 'user/:id' ,to: "user#show"
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

  get 'warehouse-consignment/(:status)/(:page)/(:perPage)', to: "consignment#index"
  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  resources :consignment, path: "warehouse-consignments", only: :show do
    collection do
      post '/:id/check', to: 'consignment#check'
      post '/:id/place', to: 'consignment#place'
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
