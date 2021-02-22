class PeticionesController < ApplicationController
  def index
    @peticiones = Peticion.all
  end

  def show
    @peticion = Peticion.find(params[:id])
  end
end
