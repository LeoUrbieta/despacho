class AuditoriaController < ApplicationController
  before_action :require_user, :require_admin
  def index
    @clientes = Cliente.joins(:audits).distinct
    @replegales = Replegal.joins(:audits).distinct
    @casos = Caso.joins(:audits).distinct
    @clientes_sin_replegal =Cliente.left_outer_joins(:replegales)
      .where("replegales.id IS NULL AND CAST(num_interno AS integer) >= CAST(600 AS integer)").order(num_interno: :asc)
  end
end
