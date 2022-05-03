class PeticionesController < ApplicationController

  before_action :require_user, except: [:new,:create]
  before_action :require_admin, only: [:edit, :update, :destroy]
  before_action :agregar_usuario_externo, only: [:create]

  PAGINA_MINIMA = 0

  def index
    crearPaginas(Peticion.count, 50, Peticion)
  end

  def show

  end

  def new
    @peticion = Peticion.new
    if usuario_externo_logged_in?
      crearPaginas(usuario_externo_actual.peticiones.count, 10, usuario_externo_actual.peticiones)
    end
  end

  def create
    @peticion = Peticion.new(peticion_params)

    if usuario_externo_logged_in?
      @peticiones = usuario_externo_actual.peticiones
    end
    
    if Peticion.first.nil?
      folio_peticion_anterior = 0
    else
      folio_peticion_anterior = Peticion.first.folio
    end
    @peticion.folio = folio_peticion_anterior + 1

    if @peticion.save
      flash[:success] = "Tu solicitud se envió con éxito con folio #" + @peticion.folio.to_s
      redirect_to root_path
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
      if @peticion.respuesta_idse.attached?
        PeticionMailer.with(peticion: @peticion).enviar_respuesta_idse.deliver_now 
        flash[:success] = "Se envió un correo al cliente con esa petición"
        redirect_to peticiones_path
      else
        flash[:success] = "Se editó la petición con éxito"
        redirect_to peticiones_path
      end
    else
      render edit
    end
  end

  def destroy
    @peticion = Peticion.find(params[:id])
    @peticion.destroy

    flash[:success] = "Se borró la petición de manera exitosa"
    redirect_to peticiones_path
  end

  private
    def peticion_params
      params.require(:peticion).permit(:nombre_trabajador, :apellido_paterno, :apellido_materno, :empresa_solicitante,
      :persona_solicitante, :movimiento, :fecha_nacimiento, :domicilio, :numero_imss, :salario_integrado, :curp, :salario_sin_integrar,
      :rfc, :fecha_para_realizar_tramite, :observaciones, :respuesta_idse, :usuario_externo_id)
    end

    def agregar_usuario_externo
      params[:peticion][:usuario_externo_id] = usuario_externo_actual.id
    end

    def require_admin
      if !usuario_actual.admin?
        flash[:danger] = "No puedes modificar los registros"
        redirect_to peticiones_path
      end
    end

    def pagination(pagina,pag_maxima,pag_minima)
      if pagina <= pag_maxima and pagina >= pag_minima
          pagina = params.fetch(:page,0).to_i
      elsif pagina > pag_maxima
        pagina = pag_maxima
      elsif pagina < pag_minima
        pagina = pag_minima 
      end
      return pagina
    end

    def crearPaginas(numero_de_peticiones, peticiones_por_pagina, peticiones)
      @pag_maximas = numero_de_peticiones / peticiones_por_pagina
      @pag_minimas = PAGINA_MINIMA
      @page = params.fetch(:page,0).to_i
      @page = pagination(@page,@pag_maximas,PAGINA_MINIMA)
      @peticiones = peticiones.offset(@page * peticiones_por_pagina).limit(peticiones_por_pagina)
    end
end
