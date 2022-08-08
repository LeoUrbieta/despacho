require "application_system_test_case"

class ClientesTest < ApplicationSystemTestCase
  setup do
    @cliente = clientes(:one)
    crear_y_entrar_como_usuario_system_test('user','user12345',false,false)
  end

  test "visiting the index" do
    click_link_or_button 'Clientes'
    assert_text "Clientes"
  end

  test "creating a Cliente" do
    visit clientes_url
    click_on "Nuevo Cliente"
    fill_in with: "199", id: 'cliente_num_interno'
    fill_in with: "EMPRESA SA DE CV", id: 'cliente_razon_social'
    fill_in with: "EMP0000001N1", id: 'cliente_rfc'
    first('input[type="checkbox"]').check
    click_on "Crear Cliente"
    assert_text "El Cliente fue creado exitosamente"
  end

  test "dar de baja Cliente" do
    visit clientes_url
    click_link @cliente.razon_social
    assert_text @cliente.num_interno
    click_link_or_button "Dar de baja como Cliente"
    assert_text "BAJA"
    assert_text "El Cliente se actualizó exitosamente"
    visit bajas_clientes_url
    assert_text @cliente.razon_social.upcase
  end

  test "updating a Cliente" do
    visit clientes_url
    click_link @cliente.razon_social
    click_on "Editar Cliente"
    fill_in with: "105", id: 'cliente_num_interno'
    find('input[value="RID"]').check
    click_button "Actualizar Cliente"
    assert_text "El Cliente se actualizó exitosamente"
    assert_text "RID"
  end

  test "usuario normal no tiene boton eliminar" do
    visit clientes_url
    click_link @cliente.razon_social
    assert_text @cliente.num_interno
    assert_no_button "Eliminar"
  end

  test "solo jefe de contabilidad puede asignar cliente nuevo a usuario" do
    click_on "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test(Rails.application.credentials.dig(:usuario_jefe_contabilidad,:usuario),'testpassword',false,true)
    click_link "Clientes"
    click_on "Nuevo Cliente"
    fill_in with: "632", id: 'cliente_num_interno'
    fill_in with: "EMPRESA ASIGNADA SA DE CV", id: 'cliente_razon_social'
    fill_in with: "EMP999999TU2", id: 'cliente_rfc'
    select 'usuario_contabilidad', from: 'cliente_user_id'
    click_on "Crear Cliente"
    assert_text "El Cliente fue creado exitosamente"
  end

  test "dar de baja Cliente debe eliminar usuario Asignado" do
    visit clientes_url
    click_link @cliente.razon_social
    assert_text @cliente.user.nombre_usuario
    click_on "Dar de baja como Cliente"
    assert_text "El Cliente se actualizó exitosamente"
    assert_no_text @cliente.user.nombre_usuario
  end
  
  test "en action contabilidad cambiar el usuario debe cambiar la lista" do
    click_on "Contabilidad"
    select 'usuario_contabilidad', from: 'id'
    click_on "Cambiar"
    assert_button "Descargar Lista de Clientes de usuario_contabilidad"
    assert_text User.find_by(nombre_usuario: 'usuario_contabilidad').clientes.first.razon_social
  end

  test "jefe de contabilidad y admin debe de tener acceso a reasignar en contabilidad" do
    click_on "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test(Rails.application.credentials.dig(:usuario_jefe_contabilidad,:usuario),'testpassword',false,true)
    click_on "Contabilidad" 
    select 'usuario_contabilidad', from: 'id'
    click_on "Cambiar"
    assert_select 'cliente_user_id', with_options: ["","usuario_contabilidad"]
    click_on "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test('administrador','testpassword',true,false)
    click_on "Contabilidad" 
    select 'usuario_contabilidad', from: 'id'
    click_on "Cambiar"
    assert_select 'cliente_user_id', with_options: ["","usuario_contabilidad"]
  end

  test "usuario normal no puede reasignar usuarios en contabilidad" do
    click_on "Contabilidad" 
    select 'usuario_contabilidad', from: 'id'
    click_on "Cambiar"
    assert_no_select 'cliente_user_id', with_options: ["","usuario_contabilidad"]
  end

  test "jefe de contabilidad y admin pueden asignar clientes" do
    click_on "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test(Rails.application.credentials.dig(:usuario_jefe_contabilidad,:usuario),'testpassword',false,true)
    click_on "Clientes"
    click_link @cliente.razon_social
    click_on "Editar Cliente"
    assert_select 'cliente_user_id', {with_options: ["","usuario_contabilidad"], selected: @cliente.user.nombre_usuario}
    select 'usuario_contabilidad', from: 'cliente_user_id'
    click_button "Actualizar Cliente"
    assert_text "usuario_contabilidad"
    assert_text "El Cliente se actualizó exitosamente"
  end

  test "usuario normal no tiene select para asignar clientes a usuarios" do
    click_on "Clientes"
    click_link @cliente.razon_social
    click_on "Editar Cliente"
    assert_no_select 'cliente_user_id', {with_options: ["","usuario_contabilidad"], selected: @cliente.user.nombre_usuario}
  end

end


