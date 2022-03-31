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

  post 'company/create', to: 'company#create'
  get 'companies/:id', to: 'company#show'
  get 'companies', to: 'company#index'
  post 'companies/update/:id', to: 'company#update'

  get 'users', to: 'user#index'
  post 'users/update/:id', to: 'user#update'
  get 'users/:id', to: 'user#show'
  get 'user/create', to: 'user#company_and_roles_list'
  post 'user/create', to: 'user#create'
  post 'companies/update/:id', to: 'company#update'
  get 'company/create', to: 'company#check_system_access'

  get 'roles', to: 'user_roles#index'

  get 'companies/:company_id/warehouses', to: 'warehouse#index'

  post 'warehouse/create', to: 'warehouse#create'
  get 'warehouse/:id', to: 'warehouse#show'
  get 'warehouses/:warehouse_id/sections', to: 'section#index'
  post 'warehouses/update/:id', to: 'warehouse#update'

  post 'consignments/create', to: 'consignment#create'
  get 'consignments', to: 'consignment#index'
  get 'consignments/:id', to: 'consignment#show'
  post 'consignments/:id/check', to: 'consignment#check'
  post 'consignments/:id/place', to: 'consignment#place'

  get 'warehouse-consignments/:id', to: 'consignment#show'
end
