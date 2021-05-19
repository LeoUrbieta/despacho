require "test_helper"

class ClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
    @cliente = clientes(:one)
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get clientes_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@usuario,"password")
    get new_cliente_url
    assert_response :success
  end

  test "should create cliente" do
    sign_in_as(@usuario,"password")
    assert_difference('Cliente.count') do
      post clientes_url, params: { cliente: {:razon_social => "Otra razon",
                                             :rfc => "OTR342345IOL",
                                             :num_interno => "432",
                                             :clave => "ABD"  } }
    end

    assert_redirected_to cliente_url(Cliente.last)
  end

  test "should show cliente" do
    sign_in_as(@usuario,"password")
    get cliente_url(@cliente)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@usuario,"password")
    get edit_cliente_url(@cliente)
    assert_response :success
  end

  test "should update cliente" do
    sign_in_as(@usuario,"password")
    patch cliente_url(@cliente), params: { cliente: {:razon_social => "Otra razon" ,
                                             :rfc => "OTR342345IOL",
                                             :num_interno => "432",
                                             :clave => "ABD"  } }
    assert_redirected_to cliente_url(@cliente)
  end

  test "should destroy cliente" do
    sign_in_as(@usuario,"password")
    assert_difference('Cliente.count', -1) do
      delete cliente_url(@cliente)
    end

    assert_redirected_to clientes_url
  end
end
