class ObligacionesController < ApplicationController
  before_action :require_user
  before_action :set_obligacion, only: %i[ edit update destroy ]
  before_action :set_cliente, only: %i[index create edit update]

  # GET :cliente_id/obligaciones 
  def index
    @obligaciones = @cliente.obligaciones.all
  end

  # GET :cliente_id/obligaciones/1/edit
  def edit
  end

  # POST :cliente_id/obligaciones
  def create
    @obligacion = Obligacion.new(obligacion_params.except(:current_id))
    @obligacion.cliente = @cliente

    #########################################
    #Esto es para solicitud turbo_stream
    if not obligacion_params[:current_id].nil?
      @usuario = User.find(obligacion_params[:current_id])
    else
      @usuario = usuario_actual
    end
    @usuario_id = @usuario.id
    @clientes = @usuario.clientes.all
    ##########################################

    respond_to do |format|
      if @obligacion.save
        format.html { redirect_to contabilidad_clientes_path, notice: "La Obligacion se creó exitosamente" }
        format.json { render :show, status: :created, location: @obligacion }
        format.turbo_stream 
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @obligacion.errors, status: :unprocessable_entity }
        format.turbo_stream 
      end
    end
  end

  # PATCH/PUT :cliente_id/obligaciones/1
  def update
    respond_to do |format|
      if @obligacion.update(obligacion_params)
        format.html { redirect_to cliente_obligaciones_url, notice: "La obligación se actualizó exitosamente" }
        format.json { render :show, status: :ok, location: @obligacion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @obligacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE :cliente_id/obligaciones/1
  def destroy
    @obligacion.destroy

    respond_to do |format|
      format.html { redirect_to cliente_obligaciones_url, notice: "Se eliminó la obligación correctamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obligacion
      @obligacion = Obligacion.find(params[:id])
    end

    def set_cliente 
      @cliente = Cliente.find(params[:cliente_id])
    end

    # Only allow a list of trusted parameters through.
    def obligacion_params
      params.require(:obligacion).permit(:fecha,:current_id)
    end
end
