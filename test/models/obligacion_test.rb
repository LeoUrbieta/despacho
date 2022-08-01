require "test_helper"

class ObligacionTest < ActiveSupport::TestCase

  def setup
    @cliente_uno = clientes(:one)
    @cliente_dos = clientes(:two)
    obligacion_con_fecha = Obligacion.create!(cliente_id: @cliente_uno.id,
                                              fecha: "2022-07-01",
                                              presentadas: ["","Obligacion1","Obligacion2"])
  end

  test "fecha debe ser unica por cliente" do
    assert_no_difference 'Obligacion.count', 'La fecha debe de ser unica' do
      Obligacion.create(cliente_id: @cliente_uno.id,
                        fecha: "2022-07-01",
                        presentadas: ["","Obligacion1","Obligacion2"])
    end
    assert_difference 'Obligacion.count' do
      Obligacion.create!(cliente_id: @cliente_dos.id,
                        fecha: "2022-07-01",
                        presentadas: ["","ObligacionA","ObligacionB"]) 
    end 
  end
end
