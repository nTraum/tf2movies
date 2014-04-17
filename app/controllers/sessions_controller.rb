# encoding: UTF-8
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    auth = env['omniauth.auth']
    user = User.where(:steam_id => auth.uid).first || User.create_with_omniauth(auth)
    user.refresh_last_login
    user.refresh_user_info(auth)
    session[:user_id] = user.id
    redirect_to((request.env['omniauth.origin'] || root_path), :notice => signin_message(user.nickname))
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back, :notice => signout_message
  end

  private

  def signout_message
    ['See you next time.', 'Adiós.', 'Bye.', 'Signed out.'].sample
  end

  def signin_message(nickname)
    ["Welcome, #{nickname}.", "Howdy, #{nickname}.", 'Signed in.', "Hello there, #{nickname}."].sample
  end
end