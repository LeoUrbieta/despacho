require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
  end

  test "Entrada invalida es rechazada" do
    get root_path
    assert_template 'peticiones/new'
    assert_select "input[id=session_nombre_usuario]"
    post login_path, params: { session: { nombre_usuario: " ", password: " "} }
    assert_template 'peticiones/new'
    assert_not flash.empty?
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "Credenciales son correctas e inicia sesion y termina sesion" do
    post login_path, params: { session: { nombre_usuario: @usuario.nombre_usuario, password: @usuario.password}}
    assert_redirected_to peticiones_path
    follow_redirect!
    assert_template 'peticiones/index'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "button[type='submit']", count: 1
    delete logout_path
    assert_redirected_to root_path
    assert_equal "Has salido de tu sesión", flash[:success]
  end

  test "Peticiones solo disponibles si Usuario Externo ha iniciado sesión" do
    get root_path
  end
end
