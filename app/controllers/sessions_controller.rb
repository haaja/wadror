class SessionsController < ApplicationController

  def new
    # render login page
  end

  def create
    # get user from db
    user = User.find_by username: params[:username]
    if user.nil? or not user.authenticate params[:password]
      redirect_to :back, notice: 'username and password do not match'
    else
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'Welcome back!'
    end
  end

  def destroy
    # reset session
    session[:user_id] = nil
    # redirect to root
    redirect_to :root
  end
end