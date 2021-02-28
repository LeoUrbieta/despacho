require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
  end

  test "Entrada invalida es rechazada" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { nombre_usuario: " ", password: " "} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    get root_path
    assert flash.empty?

  end

  test "Credenciales son correctas e inicia sesion" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { nombre_usuario: @usuario.nombre_usuario, password: @usuario.password}}
    assert_redirected_to peticiones_path
    follow_redirect!
    assert_template 'peticiones/index'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
  end
end
