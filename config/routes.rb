# config/routes.rb
#
# Routes are matched in the order listed in this file.
#
# TODO: improve login routes
# TODO - use conditional routes 'posts#new' if no posts, else 'posts#index'.

Rails.application.routes.draw do

  # Routes added automatically by `rails generate` are above this line.
  #
  # Routes below this line are organized by priority. Moving them relative
  # to the alphabetical routes farther down may break things...

  get 'home_student/show/:id', to: 'home_student#show_id'
  get 'home_student/show'

  root to: 'home_teacher#index', constraints: lambda {
     |_, request| request.env['warden'].authenticate(scope: :user)&.teacher?
  }
  root to: 'home_student#show'

  # Routes below are in alphabetical order – on the assumption that there are
  # no ordering issues. Move routes with ordering requirements above this
  # comment and indicate the requirement in a comment.

  resources :assessments do
    get 'score', on: :member
    # post 'post_scores', on: :member
  end
  resources :comments, only: [:create, :update]
  resources :courses do
    resources :rubrics
  end
  resources :objectives
  resources :posts, only: [:index]
  resources :rubrics
  resources :scores do
    post 'bulk', on: :member
  end
  resources :sections, only: :index do
    resources :users, only: [:index]
  end
  resources :tasks do
    resources :rubrics
  end
  resources :units
  resources :users, only: [:index, :edit, :update] do
    resources :posts
    # XXX: how to protect this route? Was conditional on dev environment.
      post 'become', on: :collection
  end

  # Lowest priority routes. Used for user session management.

  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end
