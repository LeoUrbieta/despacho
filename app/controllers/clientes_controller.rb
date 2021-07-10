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
        format.html { redirect_to @cliente, notice: "El cliente se creó exitosamente" }
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
end
