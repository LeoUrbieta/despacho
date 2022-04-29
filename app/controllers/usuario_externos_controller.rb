class UsuarioExternosController < ApplicationController
  before_action :set_usuario_externo, only: %i[ show edit update destroy ]
  before_action :require_user, except: %i[new create]
  before_action :require_admin, except: %i[new create]

  # GET /usuario_externos or /usuario_externos.json
  def index
    @usuario_externos = UsuarioExterno.all
  end

  # GET /usuario_externos/1 or /usuario_externos/1.json
  def show
  end

  # GET /usuario_externos/new
  def new
    @usuario_externo = UsuarioExterno.new
  end

  # GET /usuario_externos/1/edit
  def edit
  end

  # POST /usuario_externos or /usuario_externos.json
  def create
    @usuario_externo = UsuarioExterno.new(usuario_externo_params)

    respond_to do |format|
      if @usuario_externo.save
        format.html { redirect_to usuario_externo_url(@usuario_externo), notice: "Usuario externo was successfully created." }
        format.json { render :show, status: :created, location: @usuario_externo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usuario_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuario_externos/1 or /usuario_externos/1.json
  def update
    respond_to do |format|
      if @usuario_externo.update(usuario_externo_params)
        format.html { redirect_to usuario_externo_url(@usuario_externo), notice: "Usuario externo was successfully updated." }
        format.json { render :show, status: :ok, location: @usuario_externo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usuario_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuario_externos/1 or /usuario_externos/1.json
  def destroy
    @usuario_externo.destroy

    respond_to do |format|
      format.html { redirect_to usuario_externos_url, notice: "Usuario externo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario_externo
      @usuario_externo = UsuarioExterno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuario_externo_params
      params.require(:usuario_externo).permit(:nombre_usuario, :password_digest)
    end
end
