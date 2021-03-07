class PeticionesController < ApplicationController

  before_action :require_user, except: [:new, :create]
  before_action :require_admin, only: [:edit, :update, :destroy]

  def index
    @peticiones = Peticion.all
  end

  def show

  end

  def new
    @peticion = Peticion.new
  end

  def create
    @peticion = Peticion.new(peticion_params)
    if Peticion.first.nil?
      folio_peticion_anterior = 0
    else
      folio_peticion_anterior = Peticion.first.folio
    end
    @peticion.folio = folio_peticion_anterior + 1

    if @peticion.save
      flash[:success] = "Tu solicitud se envió con éxito con folio #" + @peticion.folio.to_s
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @peticion = Peticion.find(params[:id])
  end

  def update
    @peticion = Peticion.find(params[:id])

    if @peticion.update(peticion_params)
      flash[:success] = "Se editó la petición con éxito"
      redirect_to peticiones_path
    else
      render edit
    end
  end

  def destroy
    @peticion = Peticion.find(params[:id])
    @peticion.destroy

    flash[:success] = "Se borró la petición de manera exitosa"
    redirect_to peticiones_path
  end

  private
    def peticion_params
      params.require(:peticion).permit(:nombre_trabajador, :apellido_paterno, :apellido_materno, :empresa_solicitante,
      :persona_solicitante, :movimiento, :fecha_nacimiento, :domicilio, :numero_imss, :salario_integrado, :curp, :salario_sin_integrar,
      :rfc, :fecha_para_realizar_tramite, :observaciones)
    end

    def require_admin
      if !usuario_actual.admin?
        flash[:danger] = "No puedes modificar los registros"
        redirect_to peticiones_path
      end
    end
end
