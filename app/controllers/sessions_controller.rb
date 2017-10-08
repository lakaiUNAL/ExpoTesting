class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: user_params[:email].downcase)
    if user && user.authenticate( user_params[:password] )
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      #flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to root_path

  end

  private
  
  def user_params
    params.require(:session).permit(:email, :password)
  end

end
