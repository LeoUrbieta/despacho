class ClientesController < ApplicationController
  before_action :require_user
  before_action :require_admin, only: [:destroy]
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
    string_notificacion,estatus_dar_de_alta = actualizar_replegal_asociado
    respond_to do |format|
      if estatus_dar_de_alta && @cliente.save
        notice_a_poner=notice_a_mostrar(string_notificacion,"El Cliente fue creado exitosamente") 
        format.html { redirect_to @cliente, notice: notice_a_poner }
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
      params[:cliente][:user_id] = nil
    end
    string_notificacion,estatus_dar_de_alta=actualizar_replegal_asociado
    respond_to do |format|
      if estatus_dar_de_alta && @cliente.update(cliente_params)
        notice_a_poner=notice_a_mostrar(string_notificacion,"El Cliente se actualizó exitosamente")
        format.html { redirect_to @cliente, notice: notice_a_poner }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    if @cliente.destroy
      respond_to do |format|
        format.html { redirect_to clientes_url, notice: "El cliente se eliminó correctamente" }
        format.json { head :no_content }
      end
    else
      render 'show'
    end
  end

  def bajas 
    @clientes = Cliente.where("num_interno IS NULL") 
  end

  def contabilidad
    @clientes = @usuario_actual.clientes.all
  end

  def post_contabilidad
    usuario = User.find(params[:id])
    @clientes = usuario.clientes.all
    respond_to do |format|
      format.html {redirect_to contabilidad_clientes_path, notice: "Turbo streams no puede renovar la tabla"}
      format.csv {send_data @clientes.to_csv, filename: "clientes-#{Date.today}.csv"}
      format.turbo_stream
    end
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
      params[:cliente][:rfc] = params[:cliente][:rfc].mb_chars.upcase.to_s.gsub(/\s+/, "")
      params.require(:cliente).permit(:razon_social,:rfc,:num_interno,:clave,
                                      :fiel,:csd,:fiel_vencimiento,:csd_vencimiento,
                                      :user_id,
                                      )
    end

    def notice_a_mostrar(string_notificacion,string_nuevo_u_update)
      case string_notificacion
      when "REPLEGAL"
        crea_asociacion_replegal_cliente
        return notice_asociacion_nuevo_cliente_a_replegal_existente
      when "CREADOACTUALIZADO"
        unless params[:cliente][:num_interno].nil?
          if params[:cliente][:num_interno].to_i < 600
            if not @cliente.replegales.empty?
              asigna_parametros
              return "El cliente fue actualizado así como su registro de representante legal"
            end
          end
        end
        #En este caso no hay representante legal asociado
          #o se está dando de baja a un cliente.
        return string_nuevo_u_update
      end
    end

    def actualizar_replegal_asociado
      unless params[:cliente][:num_interno].nil?
        if params[:cliente][:num_interno].to_i < 600
          if not @cliente.replegales.empty?
            asigna_parametros
          else
            if Replegal.find_by(rfc: params[:cliente][:rfc])
              if params[:replegal] == "REPLEGAL"
                return "REPLEGAL", true
              else
                @cliente.errors.add(:rfc, "Este RFC ya está dado de alta en un representante legal.\n
                                   Para darlo de alta como cliente, puedes ir al registro del representante legal
                                   y dar click en el botón 'Dar de alta como cliente'")
                return "",false
              end
            end
          end
        else
          if Replegal.find_by(rfc: params[:cliente][:rfc])
            @cliente.errors.add(:rfc, "Este RFC ya está dado de alta en un representante legal.\n
                               Para darlo de alta como cliente, puedes ir al registro del representante legal
                               y dar click en el botón 'Dar de alta como cliente'")
            return "",false
          end
        end  
      end
      return "CREADOACTUALIZADO",true
    end

    def crea_asociacion_replegal_cliente
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

    def rfc_ya_tiene_rep_legal_notice
      return "Ese RFC ya está dado de alta como representante legal. Para darlo de alta como cliente
      ve a su perfil en la sección de Representantes Legales y da click en 'Dar de Alta como Cliente'"
    end


    def notice_asociacion_nuevo_cliente_a_replegal_existente
      return "El cliente se creó exitosamente y además se asoció al representante legal " +
              @cliente.replegales.first.nombre_completo 
    end
end
