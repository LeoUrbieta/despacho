require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @usuario = User.new(nombre_usuario: "Leo", password: "password", password_confirmation: "password")
  end

  test "debe haber contraseña" do
    @usuario.password = @usuario.password_confirmation = " "
    assert_not @usuario.valid?
  end

  test "contraseña debe ser minimo 5 caracteres" do
    @usuario.password = @usuario.password_confirmation = "x" * 4
    assert_not @usuario.valid?
  end
end
