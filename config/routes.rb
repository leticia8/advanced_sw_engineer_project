Rails.application.routes.draw do
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)

  # Default page after login (except redirection from email)
  root to: "home#index"

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :vote, :home, :support, :about
  resources :users
 
  resources :elections do
    resources :proposals 
  end
  resources :proposals do
    resources :options
  end

  # Home
  get '/user' => "home#index", :as => :user_root

  # Election
  get '/elections/:id', to: 'elections#show'
  get '/elections', to: 'elections#index'
  post '/elections', to: 'elections#create'
  get  '/elections/new', to: 'elections#new'
  post '/options', to: 'options#create'
  get '/elections/results/:electionId', to: 'elections#results'
  get '/elections/info/:electionId', to: 'elections#info'
  get '/elections/activate_election/:electionId', to: 'elections#activate_election'

  # Vote
  get '/vote/new/:electionId' => 'vote#new', :as => :email_vote
  get '/elections/results/:electionId' => 'elections#results', :as => :email_results
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
