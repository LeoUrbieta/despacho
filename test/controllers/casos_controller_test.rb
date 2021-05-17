require "test_helper"

class CasosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
    @cliente = clientes(:two)
    @caso = casos(:two)
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get casos_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@usuario,"password")
    get new_caso_url
    assert_response :success
  end

  test "should create caso" do
    sign_in_as(@usuario,"password")
    assert_difference('Caso.count') do 
      post casos_url, params: { caso: {:cliente_id => @caso.cliente_id,
                                       :texto_caso => @caso.texto_caso} }
    end

    #Es Caso.first porque en caso.rb el default_scope -> {order(id: :desc)}
    assert_redirected_to casos_url
  end

  test "should show caso" do
    sign_in_as(@usuario,"password")
    get caso_url(@caso)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@usuario,"password")
    get edit_caso_url(@caso)
    assert_response :success
  end

  test "should update caso" do
    sign_in_as(@usuario,"password")
    patch caso_url(@caso), params: { caso: {:cliente_id => @cliente.id,
                                            :texto_caso => "Este texto es nuevo"  } }
    assert_redirected_to casos_url
  end

  test "should destroy caso" do
    sign_in_as(@usuario,"password")
    assert_difference('Caso.count', -1) do
      delete caso_url(@caso)
    end

    assert_redirected_to casos_url
  end
end
