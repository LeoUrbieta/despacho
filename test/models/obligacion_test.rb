require "test_helper"

class ObligacionTest < ActiveSupport::TestCase

  def setup
    @cliente = clientes(:one)
    obligacion_con_fecha = Obligacion.create!(cliente_id: @cliente.id,
                                              fecha: "2022-07-01",
                                              presentadas: ["","Obligacion1","Obligacion2"])
  end

  test "fecha debe ser unica" do
    assert_no_difference 'Obligacion.count', 'La fecha debe de ser unica' do
    obligacion_con_fecha = Obligacion.create(cliente_id: @cliente.id,
                                              fecha: "2022-07-01",
                                              presentadas: ["","Obligacion1","Obligacion2"])
    end
  end
end
