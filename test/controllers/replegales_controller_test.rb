require "test_helper"

class ReplegalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario= User.create!(nombre_usuario: "Leo", password: "password")
    @replegal = replegales(:one)
    @cliente = clientes(:one)
  end

  test "should get index" do
    sign_in_as(@usuario, "password")
    get replegales_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@usuario, "password")
    get new_replegal_url
    assert_response :success
  end

  test "should create replegal" do
    sign_in_as(@usuario, "password")
    assert_difference("Replegal.count") do
      post replegales_url, params: { replegal: { nombre_completo: "Leo Moreno", rfc: "MOUL8902072X2", cliente_ids: [ "" ] } }
    end

    assert_redirected_to replegal_url(Replegal.last)
  end

  test "should show replegal" do
    sign_in_as(@usuario, "password")
    get replegal_url(@replegal)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@usuario, "password")
    get edit_replegal_url(@replegal)
    assert_response :success
  end

  test "should update replegal" do
    sign_in_as(@usuario, "password")
    patch replegal_url(@replegal), params: { replegal: { nombre_completo: "Leo Moreno", rfc: "MOUL8902072X2", cliente_ids: [ "", clientes(:six).id ] } }
    assert_redirected_to replegal_url(@replegal)
  end

  test "should destroy replegal" do
    sign_in_as(@usuario, "password")
    assert_difference("Replegal.count", -1) do
      delete replegal_url(@replegal)
    end

    assert_redirected_to replegales_url
  end

  test "should not update replegal if rfc is already in lista de clientes" do
    sign_in_as(@usuario, "password")
    patch replegal_url(@replegal), params: { replegal: { nombre_completo: "Leo Moreno", rfc: clientes(:two).rfc, cliente_ids: [ "", clientes(:six).id ] } }
    assert_response 302
  end

  test "should reassociate replegal with cliente in update" do
    sign_in_as(@usuario, "password")
    patch replegal_url(@replegal), params: { replegal: { nombre_completo: clientes(:seven).razon_social, rfc: clientes(:seven).rfc, cliente_ids: [ "" ] } }
    assert_redirected_to replegal_url(@replegal)
  end
end
