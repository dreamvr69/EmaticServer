Rails.application.routes.draw do

  namespace :ember do
      get '/users/:user_id/projects', to: 'projects#index_user'
      #get '/users/quick_load', to: 'users#quick_load'


      get '/projects', to: 'projects#index'
      #post '/projects/save', to: 'projects#save'
      post '/projects/:id/add_visualisation', to: 'projects#add_visualisation'
      post '/projects/:project_id/add_visualisation_by_id', to: 'projects#add_visualisation_by_id'
      get '/projects/:id/visualisations', to: 'projects#get_visualisations'
      patch '/projects/:id', to: 'projects#update'
      post '/projects/:id/patch', to: 'projects#update'


      get '/visualisations/:id/notes', to: 'visualisations#get_notes'
      post '/visualisations/:id/add_note', to: 'visualisations#add_note'
      delete '/visualisations/:id', to: 'visualisations#destroy'
      get '/visualisations', to: 'visualisations#index'
      get '/visualisations/last', to: 'visualisations#get_last_visualisation'
      post '/visualisations/:id/patch', to: 'visualisations#update'


      get '/franchises/:id/vr_data', to: 'franchises#get_vr_data'
      post '/franchises/:id/vr_data', to: 'franchises#post_vr_data'

      post '/notes/:id/patch', to: 'notes#update'


      post '/images', to: 'images#create'

      post '/pdf/generate', to: 'pdf#generate'

      resources :visualisations, only: [:create, :update, :show]

      resources :notes,         only: [:show, :update, :destroy]
      resources :projects,      only: [:destroy, :show, :create]

      resources :users,               only: [:show, :create, :update, :destroy] do
        collection do
          post 'authenticate'
        end
      end
      resources :franchises
    end
      devise_for :users
      mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
      mount GrapeSwaggerRails::Engine => '/swagger'

      get '*path', :to => 'application#routing_error'
      post '*path', :to => 'application#routing_error'

end
