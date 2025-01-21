class PagesController < ApplicationController
    def about
    end
    def produkty
    end
    def home
      if admin_signed_in?
        # Logic for when the admin is signed in
        @message = "Welcome back, Admin!"
      else
        # Logic for when no admin is signed in
        @message = "Please sign in to access the admin panel."
      end
    end
    def contact
    end
    def new 
    end
  end
  