Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup',
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords'
             }

  # patch 'password/edit', to: 'passwords#update', as: 'edit_password'
  post 'company', to: 'company#create'
end
