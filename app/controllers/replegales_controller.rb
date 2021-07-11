class ReplegalesController < ApplicationController
  before_action :require_user
  before_action :set_replegal, only: %i[ show edit update destroy ]

  # GET /replegales or /replegales.json
  def index
    @replegales = Replegal.all
  end

  # GET /replegales/1 or /replegales/1.json
  def show
  end

  # GET /replegales/new
  def new
    @replegal = Replegal.new
  end

  # GET /replegales/1/edit
  def edit
  end

  # POST /replegales or /replegales.json
  def create
    @replegal = Replegal.new(replegal_params)
    agregados_correctamente = agregar_clientes
    respond_to do |format|
      if not agregados_correctamente
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @replegal.errors, status: :unprocessable_entity }
      elsif @replegal.save 
        format.html { redirect_to @replegal, notice: "El Representante legal se creó correctamente" }
        format.json { render :show, status: :created, location: @replegal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @replegal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replegales/1 or /replegales/1.json
  def update
    respond_to do |format|
      agregados_correctamente = agregar_clientes
      if not agregados_correctamente
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @replegal.errors, status: :unprocessable_entity }
      elsif @replegal.update(replegal_params) 
        format.html { redirect_to @replegal, notice: "El representante legal se actualizó correctamente" }
        format.json { render :show, status: :ok, location: @replegal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @replegal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replegales/1 or /replegales/1.json
  def destroy
    @replegal.destroy
    respond_to do |format|
      format.html { redirect_to replegales_url, notice: "El representante legal se eliminó correctamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replegal
      @replegal = Replegal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def replegal_params
      if not params["clienteasociado"]["cliente_id"].empty?
        asociar_clave_fiel_csd
      end
      params[:replegal][:nombre_completo] = params[:replegal][:nombre_completo].
        mb_chars.upcase.to_s
      params[:replegal][:rfc] = params[:replegal][:rfc].mb_chars.upcase.to_s
      params.require(:replegal).permit(:nombre_completo,:rfc,:clave,:fiel,
                                       :csd,:vencimiento_fiel,:vencimiento_csd)
    end

    def agregar_clientes
      clientes_por_agregar = Array.new()
      #La condicion de size() > 1 es porque el array viene con [""] por defecto.
      #Para el caso de [""] size() == 1
      #Al poner un dato tenemos por ejemplo, ["","223"] donde size == 2
      if params["clientes"]["cliente_id"].size() > 1 
        for id_cliente in 1..params["clientes"]["cliente_id"].size()-1
          clientes_por_agregar.push(params["clientes"]["cliente_id"][id_cliente])
        end
      end
      if not params["clienteasociado"]["cliente_id"].empty?
        clientes_por_agregar.push(params["clienteasociado"]["cliente_id"])
      end
      if not clientes_por_agregar.empty?
        @replegal.cliente_ids=clientes_por_agregar
      end
      if @replegal.errors.any?
        return false
      end
      return true
    end

    def asociar_clave_fiel_csd
      cliente_por_asociar = Cliente.find(params["clienteasociado"]["cliente_id"])
      params["replegal"]["nombre_completo"] = cliente_por_asociar.razon_social
      params["replegal"]["clave"] = cliente_por_asociar.clave
      params["replegal"]["rfc"] = cliente_por_asociar.rfc
      params["replegal"]["fiel"] = cliente_por_asociar.fiel
      params["replegal"]["csd"] = cliente_por_asociar.csd 
      params["replegal"]["vencimiento_fiel"]= cliente_por_asociar.fiel_vencimiento
      params["replegal"]["vencimiento_csd"]= cliente_por_asociar.csd_vencimiento
   end
  end
