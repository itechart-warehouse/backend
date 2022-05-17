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
  post 'warehouses/update/:id', to: 'warehouse#update'

  post 'consignments/create', to: 'consignment#create'
  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  post 'warehouse-consignments/:id/check', to: 'consignment#check'
  post 'warehouse-consignments/:id/place', to: 'consignment#place'

  get 'warehouse-consignments/:id', to: 'consignment#show'
  get 'warehouse-consignments', to: 'consignment#index'

  post 'warehouse-consignments/:id/recheck', to: 'consignment#recheck'
  post 'warehouse-consignments/:id/shipp', to: 'consignment#shipp'

  get 'warehouse-consignments/:id/goods', to: 'goods#index'

  get 'warehouse-consignments/:id/reports/create', to: 'report_type#index'
  post 'warehouse-consignments/:id/reports/create', to: 'reports#create'

  get 'warehouse-consignments/:consignment_id/reports', to: 'reports#index_where_consigment_id'
  get 'reports/:report_id/goods', to: 'reports#show_reported'
end
