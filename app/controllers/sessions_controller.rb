class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: user_params[:email].downcase)
    if user && user.authenticate( user_params[:password] )
      user_params[:remember_me] == '1' ? (remember user) : (forget user)
      log_in user
      User.logger.info "usuario #{user_params[:email].downcase} inició sesión #{Time.now}"
      redirect_to user
    else
      #flash.now[:danger] = 'Invalid email/password combination'
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render :new
    end
  end

  def destroy
    debugger
    log_out if logged_in?
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

end
