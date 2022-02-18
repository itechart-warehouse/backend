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
  get 'users', to: 'user#index'
  get 'users/:id', to: 'user#show'
  post 'companies/update/:id', to: 'company#update'
end
