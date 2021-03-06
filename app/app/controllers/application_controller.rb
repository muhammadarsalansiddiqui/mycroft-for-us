class ApplicationController < ActionController::Base
	
  # Logs
  impressionist 

  helper_method :set_current_concentrator

  # Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

	def set_current_concentrator concentrator
		session[:concentrator_id] = concentrator.id
	end

	def current_concentrator
    	if session[:concentrator_id]
      		@current_concentrator ||= Concentrator.find(session[:concentrator_id])
    	else
      		@current_concentrator = nil
    	end
  	end

	protected
    def after_sign_in_path_for(resource)
    	dashboard_path || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
end
