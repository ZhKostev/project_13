Project13::Application.routes.draw do
  namespace :admin do
    get '/' => 'dashboard#index', :as => :dashboard
    resources :rubrics
  end

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

end
