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
  get 'roles', to: 'user_roles#index'
  get 'user/create', to: 'user#company_and_roles_list'
  post 'companies/update/:id', to: 'company#update'
end
