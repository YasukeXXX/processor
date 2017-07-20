module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = remember_verifier.verify(cookies[:remember_me])
      if user = User.find_by(id: user_id)
        login user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    forget current_user
    @current_user = nil
  end

  def remember(user)
    cookies.permanent[:remember_me] = remember_verifier.generate_token(user.id)
  end

  def forget(user)
    cookies.delete(:remember_me)
  end

  private

  def remember_verifier
    @remember_verifier ||= Verifier.new type: :remember
  end
end
