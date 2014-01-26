class SessionsController < ApplicationController

  def new
    # render login page
  end

  def create
    # get user from db
    user = User.find_by username: params[:username]

    # save user id to session (if the user exists)
    session[:user_id] = user.id if not user.nil?

    redirect_to user
  end

  def destroy
    # reset session
    session[:user_id] = nil
    # redirect to root
    redirect_to :root
  end
end