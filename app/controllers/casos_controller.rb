class CasosController < ApplicationController
  before_action :require_user
  before_action :set_caso, only: %i[ show edit update destroy ]

  # GET /casos or /casos.json
  def index
    @casos = Caso.where("fecha_conclusion IS NULL")
  end

  # GET /casos/1 or /casos/1.json
  def show
  end

  # GET /casos/new
  def new
    @caso = Caso.new
    @clientes = Cliente.all
  end

  # GET /casos/1/edit
  def edit
  end

  # POST /casos or /casos.json
  def create
    @caso = Caso.new(caso_params)

    respond_to do |format|
      if @caso.save
        format.html { redirect_to casos_url, notice: "El caso fue creado exitosamente" }
        format.json { render :show, status: :created, location: @caso }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @caso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /casos/1 or /casos/1.json
  def update
    respond_to do |format|
      if @caso.update(caso_params)
        format.html { redirect_to casos_url, notice: "El caso fue actualizado exitosamente" }
        format.json { render :show, status: :ok, location: @caso }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @caso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /casos/1 or /casos/1.json
  def destroy
    @caso.destroy
    respond_to do |format|
      format.html { redirect_to casos_url, notice: "El caso fue eliminado exitosamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caso
      @caso = Caso.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def caso_params
      params.require(:caso).permit(:cliente_id,:texto_caso,:fecha_conclusion)
    end
end
