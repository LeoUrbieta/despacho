require "test_helper"

class UsuarioExternoTest < ActiveSupport::TestCase
  
  test "usuario externo con peticiones no puede ser borrado" do
    assert_no_difference("UsuarioExterno.count") do
      usuario_externos(:one).destroy 
    end
  end

  test "usuario externo sin peticiones puede borrarse" do
    assert_difference("UsuarioExterno.count",-1) do
      usuario_externos(:two).destroy
    end
  end
end
