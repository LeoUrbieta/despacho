require "test_helper"

class UsuarioExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario_externo = usuario_externos(:one)
  end

  test "should get index" do
    get usuario_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_usuario_externo_url
    assert_response :success
  end

  test "should create usuario_externo" do
    assert_difference("UsuarioExterno.count") do
      post usuario_externos_url, params: { usuario_externo: { nombre_usuario: @usuario_externo.nombre_usuario, password_digest: @usuario_externo.password_digest } }
    end

    assert_redirected_to usuario_externo_url(UsuarioExterno.last)
  end

  test "should show usuario_externo" do
    get usuario_externo_url(@usuario_externo)
    assert_response :success
  end

  test "should get edit" do
    get edit_usuario_externo_url(@usuario_externo)
    assert_response :success
  end

  test "should update usuario_externo" do
    patch usuario_externo_url(@usuario_externo), params: { usuario_externo: { nombre_usuario: @usuario_externo.nombre_usuario, password_digest: @usuario_externo.password_digest } }
    assert_redirected_to usuario_externo_url(@usuario_externo)
  end

  test "should destroy usuario_externo" do
    assert_difference("UsuarioExterno.count", -1) do
      delete usuario_externo_url(@usuario_externo)
    end

    assert_redirected_to usuario_externos_url
  end
end
