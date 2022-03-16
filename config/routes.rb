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

  get 'roles', to: 'user_roles#index'

  get 'companies/:company_id/warehouses', to: 'warehouse#index'
  post 'warehouse/create', to: 'warehouse#create'
  get 'warehouse/:id', to: 'warehouse#show'
  post 'warehouses/update/:id', to: 'warehouse#update'
end
