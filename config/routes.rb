Rails.application.routes.draw do
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

  resources :company,except: :destroy
  resources :user ,except: :destroy
  get 'users/create', to: 'user#company_and_roles_list'

  get 'company/create', to: 'company#check_system_access'

  resources :user_roles ,only: [:index,:show]

  get 'companies/:company_id/warehouses', to: 'warehouse#index'
  resources :warehouse,except: :destroy

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
  # get 'reports', to: 'reports#index'
  get 'warehouse-consignments/:consignment_id/reports', to: 'reports#index_where_consigment_id'
  get 'reports/:report_id/goods', to: 'reports#show_reported'
end
