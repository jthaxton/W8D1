class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(session_token: session[session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token
    @current_user = user
  end

  def logout
    current_user.reset_session_token
    current_user.session_token = nil
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to 'api/session' unless logged_in?
  end
end
