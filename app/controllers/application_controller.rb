class ApplicationController < ActionController::Base
  helper_method :usuario_actual, :logged_in?, :usuario_externo_actual, :usuario_externo_logged_in?, :require_usuario_externo, :require_admin

  def usuario_actual
    @usuario_actual ||= User.find(session[:usuario_id]) if session[:usuario_id]
  end

  def usuario_externo_actual
    @usuario_externo_actual ||= UsuarioExterno.find(session[:usuario_externo_id]) if session[:usuario_externo_id]
  end

  def usuario_externo_logged_in?
    !!usuario_externo_actual
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

  def require_usuario_externo
    if !usuario_externo_logged_in?
      flash[:danger] = "Debes haber iniciado sesión como Cliente antes de esa acción"
      redirect_to root_path
    end
  end

  def require_admin
    if not usuario_actual.admin?
      unless usuario_actual.nombre_usuario == Rails.application.credentials.dig(:usuario_adjuntar_idse, :usuario) && request.request_method == "PATCH"
        flash[:danger] = "La página no está disponible"
        redirect_to root_path
      end
    end
  end
end
