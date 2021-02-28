class ApplicationController < ActionController::Base

  helper_method :usuario_actual, :logged_in?

  def usuario_actual
    @usuario_actual ||= User.find(session[:usuario_id]) if session[:usuario_id]
  end

  def logged_in?
    !!usuario_actual
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Debes haber iniciado sesión antes de esa acción"
      redirect_to root_path
    end
  end
end
