class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    # ||= is memoization - will only perform if @current_user doesn't exist, to stop it querying the database repeatedly
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !! makes it a boolean return - ie. if current_user is there, true, if not, false
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end
end
