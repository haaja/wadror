class SessionsController < ApplicationController

  def new
    # render login page
  end

  def create
    # get user from db
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to :back, notice: "User #{params[:username]} does not exist!"
    else
      session[:user_id] = user.id
      redirect_to user
    end
  end

  def destroy
    # reset session
    session[:user_id] = nil
    # redirect to root
    redirect_to :root
  end
end