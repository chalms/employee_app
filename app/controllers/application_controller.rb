class ApplicationController < ActionController::Base

  include AppHelper
  rescue_from UserAuthenticationService::NotAuthorized, with: :deny_access
  rescue_from Exceptions::StdError, with: :go_home

  private

  def go_home(e)
    render js: 'layouts/flash_error', e
  rescue Exceptions::StdError => e
    respond_to do |format|
      format.html { flash[:error] = e }
      format.json do
        if (e == "Not Authorized")
          render json: { error: e }, status: 401
        elsif (e == "Not Found")
          render json: { error: e }, status: 404
        end
      end
      format.js
    end
    head 500, :content_type => 'text/html'
  end

  def current_user
    raise Exceptions::StdError, "No current user" unless (_authorization_header && current_api_session_token.valid?)
    return current_api_session_token.user
  end

  def is_manager!
    raise Exceptions::StdError, "User must be a manager" unless (@user.role == 'manager')
  end

  def is_admin!
    raise Exceptions::StdError, "Must be an admin to perform this" unless (@user.role == 'companyAdmin' || @user.role == 'admin')
  end

  def deny_access
    raise Exceptions::StdError, "Invalid login information"
  end

  def signed_in?
    !!current_api_session_token.user
  end

  def api_session_token_authenticate!
    return _not_authorized
  end

  def current_api_session_token
    @current_api_session_token ||= ApiSessionToken.new(_authorization_header)
  end

  def _authorization_header
    return request.headers['HTTP_AUTHORIZATION']
  end

  def _not_authorized message = "Not Authorized"
    _error message, 401
  end

  def _not_found message = "Not Found"
    _error message, 404
  end

  def _error message, status
    render json: { error: message }, status: status
  end
end