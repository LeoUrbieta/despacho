class AuditoriaController < ApplicationController
  before_action :require_user, :require_admin
  def index
    @clientes = Cliente.joins(:audits)
    @replegales = Replegal.joins(:audits)
    @casos = Caso.joins(:audits)
  end
end
