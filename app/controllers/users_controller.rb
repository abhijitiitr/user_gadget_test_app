class UsersController < ApplicationController
  def new #form to make new user
    if signed_in?
      redirect_to user_path(@current_user.id)
    end
    @user = User.new
  end

  def create #restful route to make new user!
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:notice] = 'New user created!'
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    if is_current_user_signed_in?
      @user = User.find(params[:id])
      @gadgets = @user.gadgets
    else
      redirect_to signin_path
    end
  end

  #define strong parameters!
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end