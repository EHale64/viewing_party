class UsersController < ApplicationController
  def new; end

  def create
    new_user = User.new(user_params)
    if new_user.save && params[:password] == params[:password_confirmation]
      session[:user_id] = new_user.id
      redirect_to user_dashboard_path(new_user.id)
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = 'Passwords do not match'
      redirect_to request.referer
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to request.referer
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
