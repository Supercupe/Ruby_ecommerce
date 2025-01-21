class LocaleController < ApplicationController
    def change_locale
      Rails.logger.debug "Changing locale to: #{params[:locale]}"
      
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        session[:locale] = params[:locale]
        flash[:notice] = "Locale changed to #{params[:locale]}"
      else
        flash[:alert] = "Locale not available"
      end
      
      redirect_back(fallback_location: root_path)
    end
  end