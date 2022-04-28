class SessionsController < ApplicationController

  def new
  end

  def create
    usuario = User.find_by(nombre_usuario: params[:session][:nombre_usuario])
    if not usuario
      usuario_externo = UsuarioExterno.find_by(nombre_usuario: params[:session][:nombre_usuario])
    end
    if usuario && usuario.authenticate(params[:session][:password])
      reset_session
      session[:usuario_id] = usuario.id
      flash[:success] = "Has entrado con éxito"
      redirect_to peticiones_path
    elsif usuario_externo && usuario_externo.authenticate(params[:session][:password])
      reset_session
      session[:usuario_externo_id] = usuario_externo.id
      flash[:success] = "Bienvenido"
      redirect_to root_path
    else
      @peticion = Peticion.new #Esto es para que al hacer render 'peticiones/new' no nos marque error
      flash.now[:danger] = "Hubo un error con los datos introducidos"
      render 'peticiones/new' 
    end
  end

  def destroy
    reset_session
    if session[:usuario_id]
      session[:usuario_id] = nil
    else
      session[:usuario_externo_id] = nil
    end
    flash[:success] = "Has salido de tu sesión"
    redirect_to root_path
  end
end
