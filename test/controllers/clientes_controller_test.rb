require "test_helper"

class ClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = User.create!(nombre_usuario: "Leo", password: "password", admin: false)
    @usuario_admin = User.create!(nombre_usuario: "Admin", password: "admin", admin: true)
    @cliente_uno = clientes(:one)
    @cliente_dos = clientes(:two)
    @user_four = users(:four)
    @cliente_sin_casos_ni_obligaciones = clientes(:four)
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
                                             :clave => "ABD",
                                             :regimen_fiscal => ["","REG1","REG2"]  } }
    end

    assert_redirected_to cliente_url(Cliente.find_by(num_interno: 432))
  end

  test "should show cliente" do
    sign_in_as(@usuario,"password")
    get cliente_url(@cliente_uno)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@usuario,"password")
    get edit_cliente_url(@cliente_uno)
    assert_response :success
  end

  test "should update cliente" do
    sign_in_as(@usuario,"password")
    patch cliente_url(@cliente_uno), params: { cliente: {:razon_social => "Otra razon" ,
                                             :rfc => "OTR342345IOL",
                                             :num_interno => "432",
                                             :clave => "ABD",
                                             :fiel => "Clave",
                                             :regimen_fiscal => ["","REGMOD1","REGMOD2"]  } }
    assert_redirected_to cliente_url(@cliente_uno)
  end

  test "should destroy cliente si no tiene casos ni obligaciones" do
    #Solo Admin puede borrar clientes
    sign_in_as(@usuario_admin,"admin")
    assert_difference('Cliente.count', -1) do
      delete cliente_url(@cliente_sin_casos_ni_obligaciones)
    end
    assert_redirected_to clientes_url
  end


  test "should send cliente to lista de baja" do
    sign_in_as(@usuario,"password")
    patch cliente_url(@cliente_uno), params: { cliente: {:num_interno => "",:razon_social => "MORENO", :rfc => "MORE124587QON"}}
    @cliente_uno.reload
    assert_redirected_to cliente_path(@cliente_uno)
    assert_nil @cliente_uno.num_interno
  end

  test "should not destroy cliente si tiene casos" do
    sign_in_as(@usuario_admin,"admin")
    assert_no_difference('Cliente.count') do
      delete cliente_url(@cliente_dos)
    end
  end

  test "should not destroy cliente si tiene obligaciones registradas" do
    sign_in_as(@usuario_admin,"admin")
    assert_no_difference('Cliente.count') do
      delete cliente_url(@cliente_uno)
    end
  end

  test "El rfc y num_interno deben ser únicos" do
    sign_in_as(@usuario,"password")
    rfc_cliente_uno = @cliente_uno.rfc
    razon_cliente_uno = @cliente_uno.razon_social
    num_interno_cliente_uno = @cliente_uno.num_interno
    rfc_cliente_dos = @cliente_dos.rfc
    razon_cliente_dos = @cliente_dos.razon_social
    assert_no_difference 'Cliente.count' do
      patch cliente_url(@cliente_dos), params: { cliente: {:rfc => rfc_cliente_uno, :razon_social => razon_cliente_uno}}
      patch cliente_url(@cliente_dos), params: { cliente: {:num_interno => num_interno_cliente_uno, :razon_social => razon_cliente_dos, :rfc => rfc_cliente_dos}}
    end
  end

  test "Dar de baja cliente debe eliminar usuario asignado" do
    sign_in_as(@usuario,"password")
    assert_difference '@user_four.clientes.count', -1 do
      patch cliente_url(@cliente_uno), params: { cliente: {:num_interno => "",
                                                           :razon_social => @cliente_uno.razon_social,
                                                           :rfc => @cliente_uno.rfc,
                                                           :clave => @cliente_uno.clave,
                                                           "fiel_vencimiento(3i)" => @cliente_uno.fiel_vencimiento.day,
                                                           "fiel_vencimiento(2i)" => @cliente_uno.fiel_vencimiento.month,
                                                           "fiel_vencimiento(1i)" => @cliente_uno.fiel_vencimiento.year,
                                                           "csd_vencimiento(3i)" => @cliente_uno.csd_vencimiento.day,
                                                           "csd_vencimiento(2i)" => @cliente_uno.csd_vencimiento.month,
                                                           "csd_vencimiento(1i)" => @cliente_uno.csd_vencimiento.year,
                                                           :regimen_fiscal => @cliente_uno.regimen_fiscal}}
      @cliente_uno.reload
      assert_nil @cliente_uno.user_id
    end
  end
  
end
