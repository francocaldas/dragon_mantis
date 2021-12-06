# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #before_action :authenticate_user!
  #before_action :authenticate_headhunter!
  
  
  protected

    def after_sign_in_path_for(resource)
      if user_signed_in?
        if !current_user.profiles.exists? || current_user.profiles.incomplete
          new_profile_path
        else
          root_path
        end
      else
        root_path
      end
    end
end
