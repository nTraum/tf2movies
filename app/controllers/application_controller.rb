class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :user_refresh_last_online, :categories_navbar, :pending_movies_count_navbar
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def categories_navbar
    @game_modes_navbar = GameMode.all
    @tf2_classes_navbar = Tf2Class.all
    @regions_navbar = Region.all
  end

  def user_refresh_last_online
    if current_user && (Time.zone.now - current_user.last_online > 5.minutes)
      current_user.refresh_last_online
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session.delete :user_id
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    if request.env["HTTP_REFERER"]
      redirect_to :back
    else
      redirect_to root_path
    end
  end

  def pending_movies_count_navbar
    if policy(Movie).manage?
      @pending_movies_count_navbar = Movie.where(status_cd: Movie.pending).size
    end
  end
end
