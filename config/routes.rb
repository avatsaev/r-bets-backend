Rails.application.routes.draw do

  #require 'sidekiq/web'
  #mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'

  
  namespace :api, :defaults => { :format => 'json' } do

    namespace :v1 do

      resources :bets, only: [:index, :new, :create, :show, :trending] do
        resources :votes, only: [:create, :index]
        collection do
          get :trending
        end
      end

    end

  end

  root to: "application#health_check"



end
