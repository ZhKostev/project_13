Project13::Application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    get '/' => 'dashboard#index', :as => :dashboard
  end

end
