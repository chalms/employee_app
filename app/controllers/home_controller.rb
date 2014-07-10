class HomeController < ApplicationController
	def home
		@user = current_user
	end

	def admin
		@user = current_user
    validate_admin!
	end

  def upload
    @user = current_user
    validate_admin!
    @user.company.import_employee_logs(params[:file])
  end

private

  def validate_admin!
    raise Exceptions::StdError, "Must be a company administrator to use this functionality" unless (@user.role == 'companyAdmin')
  end

	def _provided_valid_password?
    params[:password] && UserAuthenticationService.authenticate_with_password!(@user, params[:password])
  end

  def _provided_valid_api_session_token?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end