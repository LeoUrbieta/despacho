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
      params[:replegal][:nombre_completo] = params[:replegal][:nombre_completo].
        mb_chars.upcase.to_s
      params[:replegal][:rfc] = params[:replegal][:rfc].mb_chars.upcase.to_s
      params.require(:replegal).permit(:nombre_completo,:rfc,:clave,:fiel,
                                       :csd,:vencimiento_fiel,:vencimiento_csd,
                                       :cliente_ids => [])
    end

    def agregar_clientes
      clientes_por_agregar = Array.new()
      #La condicion de size() > 1 es porque el array viene con [""] por defecto.
      #Para el caso de [""] size() == 1
      #Al poner un dato tenemos por ejemplo, ["","223"] donde size == 2
      if params[:replegal][:cliente_ids].size() > 1 
        params["replegal"]["cliente_ids"].delete_at(0)
        if params["replegal"]["cliente_ids"].one? { |id| Cliente.find(id).num_interno.to_i < 600}
          se_pudo_asociar = asociar_clave_fiel_csd
          if not se_pudo_asociar
            if @replegal
              clientes_por_agregar.push(@replegal.clientes.first.id)
            end
          end
        elsif not params[:replegal][:cliente_ids].none? { |id| Cliente.find(id).num_interno.to_i < 600}
          if not @replegal
            @replegal = Replegal.new()
          end
          @replegal.errors.add(:base,"Un representante legal solo puede estar asociado
                               a una persona física")
          return false
        end
        for id_cliente in 0..params[:replegal][:cliente_ids].size()-1
          clientes_por_agregar.push(params[:replegal][:cliente_ids][id_cliente])
        end
      end
      if not @replegal 
        @replegal = Replegal.new(replegal_params) 
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
      indice_persona_fisica = params["replegal"]["cliente_ids"].
        index { |id| Cliente.find(id.to_i).num_interno.to_i < 600 }
      cliente_por_asociar = Cliente.find(params["replegal"]["cliente_ids"][indice_persona_fisica])
      if cliente_por_asociar.replegales.empty?
        params["replegal"]["nombre_completo"] = cliente_por_asociar.razon_social
        params["replegal"]["clave"] = cliente_por_asociar.clave
        params["replegal"]["rfc"] = cliente_por_asociar.rfc
        params["replegal"]["fiel"] = cliente_por_asociar.fiel
        params["replegal"]["csd"] = cliente_por_asociar.csd 
        params["replegal"]["vencimiento_fiel(1i)"]= cliente_por_asociar.fiel_vencimiento.year.to_s
        params["replegal"]["vencimiento_fiel(2i)"] = cliente_por_asociar.fiel_vencimiento.month.to_s
        params["replegal"]["vencimiento_fiel(3i)"] = cliente_por_asociar.fiel_vencimiento.day.to_s
        params["replegal"]["vencimiento_csd(1i)"]= cliente_por_asociar.csd_vencimiento.year.to_s
        params["replegal"]["vencimiento_csd(2i)"]= cliente_por_asociar.csd_vencimiento.month.to_s
        params["replegal"]["vencimiento_csd(3i)"]= cliente_por_asociar.csd_vencimiento.day.to_s
      end
      return actualiza_cliente_asociado(cliente_por_asociar)
   end

    def actualiza_cliente_asociado(cliente_por_asociar)
      fecha_vencimiento_fiel = params[:replegal]["vencimiento_fiel(3i)"] + "-" +
                               params[:replegal]["vencimiento_fiel(2i)"] + "-" +
                               params[:replegal]["vencimiento_fiel(1i)"] 
      fecha_vencimiento_csd =  params[:replegal]["vencimiento_csd(3i)"] + "-" +
                               params[:replegal]["vencimiento_csd(2i)"] + "-" +
                               params[:replegal]["vencimiento_csd(1i)"] 
      persona_fisica_pudo_actualizarse = cliente_por_asociar.update(razon_social: params[:replegal][:nombre_completo], 
                                       rfc: params[:replegal][:rfc],
                                       clave: params[:replegal][:clave], 
                                       fiel: params[:replegal][:fiel], 
                                       csd: params[:replegal][:csd],
                                       fiel_vencimiento: fecha_vencimiento_fiel, 
                                       csd_vencimiento: fecha_vencimiento_csd)
      return persona_fisica_pudo_actualizarse
    end
  end
