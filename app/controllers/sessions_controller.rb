class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username],
                                     user_params[:password])
    if user
      log_in!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Incorrect username/password combination"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    @user = current_user
    log_out!(@user)
    redirect_to new_session_url
  end
end
