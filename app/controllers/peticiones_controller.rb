class PeticionesController < ApplicationController

  def index
    @peticiones = Peticion.all
  end

  def show
    @peticion = Peticion.find(params[:id])
  end

  def new
    @peticion = Peticion.new
  end

  def create
    @peticion = Peticion.new(peticion_params)

    if @peticion.save
      redirect_to @peticion
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
      redirect_to @peticion
    else
      render edit
    end
  end

  def destroy
    @peticion = Peticion.find(params[:id])
    @peticion.destroy

    redirect_to root_path
  end

  private
    def peticion_params
      params.require(:peticion).permit(:nombre_trabajador, :apellido_paterno, :apellido_materno, :empresa_solicitante,
      :persona_solicitante, :movimiento, :fecha_nacimiento, :domicilio, :numero_imss, :salario_integrado, :curp, :salario_sin_integrar,
      :rfc, :fecha_para_realizar_tramite, :observaciones)
    end

end
