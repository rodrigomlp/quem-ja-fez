Rails.application.routes.draw do
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } # ~> Facebook connection


  # Pages
  root to: 'pages#home' #defaults root to home
  get 'about', to: "pages#about" # About us
  get 'info', to: "pages#info" # Undergraduate sign up explanation page

  # Users
  resources :users, only: [:index, :show], path: "/results" do
    get 'notify_interest', to: 'users#notify_interest', as: :notify_interest
    # member do
      # get 'schedule', to: 'users#schedule'
      # get '/schedule/confirm', to: 'users#confirm'
      resources :events do
        collection do
          get '/confirm', to: 'events#confirm'
        end
      end
  end

  get '/success_page', to: 'events#success'
  resources :meetings, only: [:create]

  get "/profile/meetings/confirm_payment", to: "profile/meetings#confirm_payment"

  namespace :profile do
    resources :resumes, only: [:index, :create, :update, :destroy]
    resources :meetings, only: [:index, :show, :create, :update, :destroy, :edit]
    resource  :info, only: [:edit, :update]
    resource  :verification, only: [:new, :create] do
      member do
        get '/email_confirmation', to: 'verifications#email_confirmation'
      end
    end
  end


end
