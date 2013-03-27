class Admin::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_admin!
  before_filter :ensure_en_locale
  layout 'admin'

  private
  def ensure_en_locale
    I18n.locale = :en
  end
end