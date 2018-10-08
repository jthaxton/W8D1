class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if @user
      login(@user)
      redirect_to '/'
    else
      render json: ['invalid login credentials'], status: 401
      # redirect_to 'api/session'
    end
  end

  def destroy
    if logout
      render 'api/sessions/emptyobj'
    else
      render json: ['error, nobody logged in'], status: 404
    end
  end


end
