Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: :new
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
  resources :comments, only: [:create, :show] do
    get 'new_nested', on: :member
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
end
