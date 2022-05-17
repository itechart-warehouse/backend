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
    get '/create', to: 'company#check_system_access',on: :collection
  end

  resources :user ,except: :destroy do
    collection do
    get '/create', to: 'user#company_and_roles_list'
    resources :user_roles ,only: :index
    end
  end

  resources :warehouse,except: [:destroy,:index]

  resources :consignment,only: [:create,:show,:index] do
    put '/check', to: 'consignment#check'
    put '/place', to: 'consignment#place'
    put '/recheck', to: 'consignment#recheck'
    put '/shipp', to: 'consignment#shipp'
    get '/reports', to: 'reports#index_where_consigment_id'
    get 'reports/:report_id/goods', to: 'reports#show_reported',on: :collection
    resources :goods,only: :index
    resources :reports,only: :create do
      collection do
        resources :report_type,only: :index
      end
    end
  end
  # get 'consignments', to: 'consignment#index'
  # get 'consignments/:id', to: 'consignment#show'
  # get 'reports', to: 'reports#index'
end
