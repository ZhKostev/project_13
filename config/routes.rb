Project13::Application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
end
