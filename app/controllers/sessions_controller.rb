class SessionsController < ApplicationController
  #bring up a form for a new session aka login form
  def new
    if signed_in?
      redirect_to user_path(@current_user)
    end
  end

  #create the session resource ie, let user log in
  def create
    #this references the funciton we made in user.rb
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash[:error] = "couldn't find a user with those credentials"
      #if there is an error, redirect back to login
      redirect_to new_session_path
  	else
  		sign_in user #helper function
  		redirect_to user
  	end

  end

  def destroy
  	sign_out #helper function 
  	redirect_to signin_path
  end

end