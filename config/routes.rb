Rails.application.routes.draw do
  # Routes are matched in the order listed.
  # TODO: fix login routes
  # TODO - use conditional routes 'posts#new' if no posts, else 'posts#index'.
  root to: 'sections#index', constraints: lambda {
     |_, request| request.env['warden'].authenticate(scope: :user)&.teacher?
  }
  root to: 'posts#index'

  resources :assessments
  resources :courses
  resources :posts, only: [:index]
  resources :sections, only: :index do
    resources :users, only: [:index]
  end
  resources :tasks
  resources :users, only: [:index, :edit, :update] do
    resources :posts
    if Rails.env.development?
      post 'become', on: :member
    end
  end
  resources :comments, only: [:create, :update]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
