Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
  namespace :api, :defaults => { :format => 'json' } do

    namespace :v1 do

      resources :bets, only: [:index, :new, :create, :show] do
        resources :votes, only: [:create, :index]
      end

    end

  end



end
