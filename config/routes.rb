Rails.application.routes.draw do
  # Routes are matched in the order listed.
  # TODO: fix login routes
  # TODO - use conditional routes 'posts#new' if no posts, else 'posts#index'.
  root to: 'sections#index', constraints: lambda {
     |_, request| request.env['warden'].authenticate(scope: :user)&.teacher?
  }
  # binding pry
  root to: 'posts#user_index'
  #root 'users/:user_id/posts' => 'posts#index', controller: 'posts', action: 'index'
  #get 'users/:user_id/posts' => 'posts#index', :as => :root

  # TODO: figure out how to route to the users posts as the default route
  # when a student logs in.
  #
  # root get 'users/:user_id/posts' => 'posts#index'
  # match 'users/:user_id/posts' => 'posts#index', :as => :root
  # root :to => 'posts#index'

  resources :assessments
  resources :courses
  resources :posts, only: [:index]
  resources :sections, only: :index do
    resources :users, only: [:index]
  end
  resources :tasks
  resources :users, only: [:index, :edit, :update] do
    resources :posts
  end

  #get 'sections/index'
  #get 'users/:user_id/posts' => 'posts#index'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
