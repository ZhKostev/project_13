Project13::Application.routes.draw do

  namespace :admin do
    get '/' => 'dashboard#index', :as => :dashboard
    resources :rubrics
    resources :articles
  end

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  resources :rubrics, :only => [:index, :show]

  root :to => 'rubrics#index'
end
