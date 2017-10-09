module SessionsHelper
  
  # Remembers a user in a persistent session.
  def remember(user)
    user.remember # Generar el token 
    cookies.permanent.signed[:user_id] = user.id  # Guardar en las cockies con clave :user_id el id del usuario
    cookies.permanent[:remember_token] = user.remember_token  # guardar el token sin encriptar
  end

   # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    #debugger
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end
end
