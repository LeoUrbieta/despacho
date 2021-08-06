class AuditoriaController < ApplicationController
  before_action :require_user, :require_admin
  def index
    @clientes = Cliente.joins(:audits).distinct
    @replegales = Replegal.joins(:audits).distinct
    @casos = Caso.joins(:audits).distinct
  end
end
