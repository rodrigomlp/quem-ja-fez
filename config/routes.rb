Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # Pages
  root to: 'pages#home' #defaults root to home
  get 'about', to: "pages#about" # About us
  get 'info', to: "pages#info" # Undergraduate sign up explanation page

  # Users
  resources :users, only: [:index, :show], path: "/results" do
    member do
      get 'schedule', to: 'users#schedule'
      get '/schedule/confirm', to: 'users#confirm'
    end

  end
  resources :meetings, only: [:create]

  namespace :profile do
    resources :resumes, only: [:index, :create, :update, :destroy]
    resources :meetings, only: [:index]
    resource :info, only: [:edit, :update]
  end


  # get 'profile/edit', to: 'users#edit'
  # get 'profile/update', to: 'users#update'
end
