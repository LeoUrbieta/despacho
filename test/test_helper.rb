ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(user, password)
    post login_path, params: {session: { nombre_usuario: user.nombre_usuario, password: password}}
  end

  def crear_y_entrar_como_usuario_system_test(usuario,pass, admin)
    User.create!(nombre_usuario: usuario, password: pass, admin: admin)
    visit root_path
    fill_in with: usuario, id: 'session_nombre_usuario'
    fill_in with: pass, :id => 'session_password'
    click_on "Entrar"
    assert_text "Has entrado con éxito"
  end
end
