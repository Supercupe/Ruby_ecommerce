class ApplicationController < ActionController::Base
  protected
  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    root_path
  end

  def check_admin_priv
    if !current_admin
      redirect_to root_path
    end
  end

  around_action :switch_locale

  def switch_locale(&action)
    locale = session[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
