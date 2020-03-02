class ApplicationController < ActionController::Base
 
  before_action :load_schema, :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:email, :password, :password_confirmation, :remember_me)}
      devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_me)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation, :current_password) }
    end

    def load_schema
      # Apartment::Tenant.switch!('public')
      Apartment::Tenant.reset
      return unless request.subdomain.present?

      account = Account.where(subdomain: request.subdomain).first
      if account
        Apartment::Tenant.switch!(request.subdomain)
      else
        redirect_to root_url(request.domain)
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end

    # def validate_subdomain
    #   redirect_to welcome_root_path unless Account.where(subdomain: request.subdomain).first
    # end
end
