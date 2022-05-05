require "test_helper"

class UsuarioExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario_externo = usuario_externos(:one)
    @usuario_externo_sin_peticiones = usuario_externos(:two)
    @usuario_interno = User.create!(nombre_usuario: "Leo", password: "password")
    @admin = User.create!(nombre_usuario: "LeoAdmin", password: "admin", admin: true)
  end

  test "should get index" do
    sign_in_as(@admin,"admin")
    get usuario_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_usuario_externo_url
    assert_response :success
  end

  test "should create usuario_externo" do
    #Al usuario que no ha sigo login in, debe regresarlo al root path
    assert_difference_create("info1@example.com")
    assert_redirected_to root_path
    assert_not flash.empty?
    #A un usuario normal debe de regresarlo al root_path
    sign_in_as(@usuario_interno,"password")
    assert_difference_create("info2@example.com")
    assert_redirected_to root_path
    assert_not flash.empty?
    #Al usuario que es admin y login debe redirigirlo al show del usuario externo recien creado
    sign_in_as(@admin,"admin")
    assert_difference_create("info3@example.com")
    assert_redirected_to usuario_externo_url(UsuarioExterno.last)
    assert_not flash.empty?
    #A un usuario normal debe de regresarlo al root_path
  end

  test "should show usuario_externo" do
    sign_in_as(@admin,"admin")
    get usuario_externo_url(@usuario_externo)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@admin,"admin")
    get edit_usuario_externo_url(@usuario_externo)
    assert_response :success
  end

  test "should update usuario_externo" do
    sign_in_as(@admin,"admin")
    patch usuario_externo_url(@usuario_externo), params: { usuario_externo: { nombre_usuario: @usuario_externo.nombre_usuario, password: @usuario_externo.password_digest, password_confirmation: @usuario_externo.password_digest } }
    assert_redirected_to usuario_externo_url(@usuario_externo)
  end

  test "should destroy usuario_externo si no tiene peticiones" do
    sign_in_as(@admin,"admin")
    assert_difference("UsuarioExterno.count", -1) do
      delete usuario_externo_url(@usuario_externo_sin_peticiones)
    end
    assert_not flash.empty?
    assert_equal "Usuario externo fue eliminado correctamente.", flash[:notice]
    assert_redirected_to usuario_externos_url
  end

  test "Usuario que tiene peticiones no puede ser destruido" do
  sign_in_as(@admin,"admin")
  assert_no_difference("UsuarioExterno.count") do
    delete usuario_externo_url(@usuario_externo)
  end
  assert_select "h2", "1 error impidieron completar tu solicitud."
  assert_template :show
  end

  private

  def assert_difference_create(nombre) 
    assert_difference("UsuarioExterno.count") do
      post usuario_externos_url, params: { usuario_externo: { nombre_usuario: nombre, password: "passwordyeah", password_confirmation: "passwordyeah"} }
    end
  end
end
