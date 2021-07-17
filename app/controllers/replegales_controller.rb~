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
    rfc_introducido_en_campo = replegal_params[:rfc]
    agregados_correctamente,@replegal = Replegal.agregar_clientes(replegal_params,nil)
    if Cliente.find_by(rfc: rfc_introducido_en_campo)
      existe_en_clientes = true 
      @replegal.errors.add(:rfc, "Ese RFC ya está dado de alta en la lista de clientes.
                           Por favor, elígelo de la lista directamente")
    else
      existe_en_clientes = false 
    end
    respond_to do |format|
      if existe_en_clientes || !agregados_correctamente
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
    rfc_introducido_en_campo = replegal_params[:rfc]
    agregados_correctamente,@replegal,params = Replegal.agregar_clientes(replegal_params,@replegal)
    if Cliente.find_by(rfc: rfc_introducido_en_campo)
      existe_en_clientes = true 
      @replegal.errors.add(:rfc, "Ese RFC ya está dado de alta en la lista de clientes.
                           Por favor, elígelo de la lista directamente")
    else
      existe_en_clientes = false 
    end
    respond_to do |format|
      if existe_en_clientes || !agregados_correctamente
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @replegal.errors, status: :unprocessable_entity }
      elsif @replegal.update(params) 
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
      params[:replegal][:rfc] = params[:replegal][:rfc].mb_chars.upcase.to_s.gsub(/\s+/, "")
      params.require(:replegal).permit(:nombre_completo,:rfc,:clave,:fiel,
                                       :csd,:vencimiento_fiel,:vencimiento_csd,
                                       :cliente_ids => [])
    end
end
