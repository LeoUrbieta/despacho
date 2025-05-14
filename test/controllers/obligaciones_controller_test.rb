require "test_helper"

class ObligacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @obligacion = obligaciones(:one)
    @cliente = @obligacion.cliente
    @usuario = User.create!(nombre_usuario: "Lein", password: "password", admin: false)
    @obligacion_dos = obligaciones(:two)
  end

  test "should get index" do
    sign_in_as(@usuario, "password")
    get cliente_obligaciones_path(@cliente)
    assert_response :success
  end

  test "should create obligacion" do
    sign_in_as(@usuario, "password")
    assert_difference("Obligacion.count") do
      post cliente_obligaciones_path(@obligacion), params: { cliente_id: @cliente.id, obligacion: { fecha: "2022-09-09", presentadas: [ "B1", "B2" ] } }
    end

    assert_redirected_to contabilidad_clientes_path
  end

  test "should get edit" do
    sign_in_as(@usuario, "password")
    get edit_cliente_obligacion_url(@cliente, @obligacion)
    assert_response :success
  end

  test "should update obligacion" do
    sign_in_as(@usuario, "password")
    patch cliente_obligacion_url(@cliente, @obligacion), params: { obligacion: { fecha: "2021-10-12" } }
    assert_redirected_to cliente_obligaciones_path
  end

  test "should destroy obligacion" do
    sign_in_as(@usuario, "password")
    assert_difference("Obligacion.count", -1) do
      delete cliente_obligacion_url(@cliente, @obligacion)
    end

    assert_redirected_to cliente_obligaciones_url
  end

  test "should not update obligacion if another one exists with same date and belongs to same cliente" do
    # obligaciones(:three) tiene fecha "2022-01-01"
    sign_in_as(@usuario, "password")
    assert_no_difference("Obligacion.count") do
      patch cliente_obligacion_url(@obligacion_dos.cliente, @obligacion_dos), params: { obligacion: { fecha: "2022-01-01" } }
    end
    assert_response 422
    assert_template :edit
  end
end
