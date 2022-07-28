require "test_helper"

class ObligacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @obligacion = obligaciones(:one)
    @cliente = @obligacion.cliente
    @usuario = User.create!(nombre_usuario: "Lein", password: "password", admin: false)
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get cliente_obligaciones_path(@cliente)
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@usuario,"password")
    get new_cliente_obligacion_url(@obligacion)
    assert_response :success
  end

  test "should create obligacion" do
    sign_in_as(@usuario,"password")
    assert_difference("Obligacion.count") do
      post cliente_obligaciones_path(@obligacion), params: { :cliente_id => @cliente.id, obligacion: { :fecha => "2022-09-09", :presentadas => ["B1","B2"]} }
    end

    assert_redirected_to contabilidad_clientes_path
  end

  test "should get edit" do
    sign_in_as(@usuario,"password")
    get edit_cliente_obligacion_url(@cliente,@obligacion)
    assert_response :success
  end

  test "should update obligacion" do
    sign_in_as(@usuario,"password")
    patch cliente_obligacion_url(@cliente,@obligacion), params: { obligacion: { :fecha => "2021-10-12"} }
    assert_redirected_to cliente_obligaciones_path
  end

  test "should destroy obligacion" do
    sign_in_as(@usuario,"password")
    assert_difference("Obligacion.count", -1) do
      delete cliente_obligacion_url(@cliente,@obligacion)
    end

    assert_redirected_to cliente_obligaciones_url
  end
end
