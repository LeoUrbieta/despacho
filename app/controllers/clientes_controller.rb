class ClientesController < ApplicationController
  before_action :require_user
  before_action :set_cliente, only: %i[ show edit update destroy ]

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all.where("num_interno IS NOT NULL").order(num_interno: :asc)

    respond_to do |format|
      format.html
      format.csv {send_data @clientes.to_csv, filename: "clientes-#{Date.today}.csv"}
    end
  end

  # GET /clientes/1 or /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      if @cliente.save
        se_encontro_replegal_previo = actualizar_replegal_asociado
        if se_encontro_replegal_previo
          notice = notice_asociacion_nuevo_cliente_a_replegal_existente 
        else
          notice = "El cliente se creó exitosamente"  
        end
        format.html { redirect_to @cliente, notice: notice }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update

    if not params[:cliente][:num_interno].nil? and params[:cliente][:num_interno].empty?
      params[:cliente][:num_interno] = nil
    end
    respond_to do |format|
      if @cliente.update(cliente_params)
        actualizar_replegal_asociado
        format.html { redirect_to @cliente, notice: "El cliente se actualizó exitosamente" }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "El cliente se eliminó correctamente" }
      format.json { head :no_content }
    end
  end

  def bajas 
    @clientes = Cliente.where("num_interno IS NULL") 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params[:cliente][:razon_social] = params[:cliente][:razon_social].
        mb_chars.upcase.to_s
      params[:cliente][:rfc] = params[:cliente][:rfc].mb_chars.upcase.to_s
      params.require(:cliente).permit(:razon_social,:rfc,:num_interno,:clave,
                                      :fiel,:csd,:fiel_vencimiento,:csd_vencimiento)
    end

    def actualizar_replegal_asociado
      if params[:cliente][:num_interno].nil?
        #@cliente.replegales.clear         
      end
      if params[:cliente][:num_interno].to_i < 600
        if not @cliente.replegales.empty?
          asigna_parametros
        else
          if Replegal.find_by(rfc: params[:cliente][:rfc])
            solo_crea_asociacion
            return true
          end
        end
      end  
      return false
    end

    def solo_crea_asociacion
      replegal_a_asociar = Replegal.find_by(rfc: params[:cliente][:rfc])
      replegal_a_asociar.clientes << @cliente
    end

    def asigna_parametros
      fecha_vencimiento_fiel = params[:cliente]["fiel_vencimiento(3i)"] + "-" +
                               params[:cliente]["fiel_vencimiento(2i)"] + "-" +
                               params[:cliente]["fiel_vencimiento(1i)"] 
      fecha_vencimiento_csd =  params[:cliente]["csd_vencimiento(3i)"] + "-" +
                               params[:cliente]["csd_vencimiento(2i)"] + "-" +
                               params[:cliente]["csd_vencimiento(1i)"] 
 
      @cliente.replegales.first.update(nombre_completo: params[:cliente][:razon_social], 
                                       rfc: params[:cliente][:rfc],
                                       clave: params[:cliente][:clave], 
                                       fiel: params[:cliente][:fiel], 
                                       csd: params[:cliente][:csd],
                                       vencimiento_fiel: fecha_vencimiento_fiel, 
                                       vencimiento_csd: fecha_vencimiento_csd)
    end

    def notice_asociacion_nuevo_cliente_a_replegal_existente
      return "El cliente se creó exitosamente y además se asoció al representante legal " +
              @cliente.replegales.first.nombre_completo + " ya que tienen el mismo RFC. En
              este momento los dos tienen datos con los cuales se dieron de alta, sin embargo,
              en cualquier actualización del cliente o representante legal, los datos se copiarán
              automáticamente del uno al otro. Si quieres que este nuevo cliente mantenga 
              sus datos y los del representante legal
              sean los que cambien, entra nuevamente a 'Editar Cliente' y da en actualizar nuevamente.\n
      
              En cambio, si quieres que los datos del Representante Legal sean los que permanecen,
              entonces ve a la sección de Representantes Legales, elige el representante legal y
              sin cambiar nada, solo da click en Actualizar. Esto copiará los datos automáticamente a
              este nuevo cliente\n. De esta manera quedarán asociados y cualquier
              cambio que realices en el futuro se aplicará automáticamente a ambos." 
    end
end
