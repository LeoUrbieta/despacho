class SessionsController < ApplicationController

  def new

  end

  def create
    usuario = User.find_by(nombre_usuario: params[:session][:nombre_usuario])
    if usuario && usuario.authenticate(params[:session][:password])
      reset_session
      session[:usuario_id] = usuario.id
      flash[:success] = "Has entrado con éxito"
      redirect_to peticiones_path
    else
      flash.now[:danger] = "Hubo un error con los datos introducidos"
      render 'new'
    end
  end

  def destroy
    reset_session
    session[:usuario_id] = nil
    flash[:success] = "Has salido de tu sesión"
    redirect_to root_path
  end

end
