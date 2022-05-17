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

  resources :company,except: :destroy do
    resources :warehouse,only: :index
  end

  resources :user ,except: :destroy

  get 'users/create', to: 'user#company_and_roles_list'

  get 'company/create', to: 'company#check_system_access'

  resources :user_roles ,only: [:index,:show]

  resources :warehouse,except: [:destroy,:index]

  resources :consignment,only: [:create,:show,:index] do
    put '/check', to: 'consignment#check'
    put '/place', to: 'consignment#place'
    put '/recheck', to: 'consignment#recheck'
    put '/shipp', to: 'consignment#shipp'
    get '/reports', to: 'reports#index_where_consigment_id'
    resources :reports,only: :create
    resources :report_type,only: :index
    resources :goods,only: :index
  end
  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  # get 'reports', to: 'reports#index'

  get 'reports/:report_id/goods', to: 'reports#show_reported'
end
