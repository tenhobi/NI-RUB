Rails.application.routes.draw do
  root 'posts#index'

  get 'about' => 'home#about'

  get 'posts' => redirect('')
  get 'posts/tag(/:tag)' => 'posts#tag', :as => :tag_filter, :defaults => { :tag => "" }
  resources :posts

  devise_for :users
  get 'users/:username' => 'users#show', :as => 'user_profile'
  get 'users/search(/:username)' => 'users#search', :as => 'user_search'
end
