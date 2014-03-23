class ApplicationController < ActionController::Base

  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :user_refresh_last_online, :navbar_categories
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def navbar_categories
    @game_modes_navbar = GameMode.all
    @tf2_classes_navbar = Tf2Class.all
    @regions_navbar = Region.all
  end

  def user_refresh_last_online
    if current_user and (Time.now - current_user.last_online > 5.minutes)
      current_user.refresh_last_online
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to root_path
    end
  end
end
