require "application_system_test_case"

class ClientesTest < ApplicationSystemTestCase
  setup do
    @cliente = clientes(:one)
    crear_y_entrar_como_usuario_system_test('user','user12345',false)
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
    click_button "Actualizar Cliente"
    assert_text "El Cliente se actualizó exitosamente"
  end

  test "usuario normal no tiene boton eliminar" do
    visit clientes_url
    click_link @cliente.razon_social
    assert_text @cliente.num_interno
    assert_no_button "Eliminar"
  end

  test "asignar cliente existente a usuario" do
    visit clientes_url
    click_link @cliente.razon_social
    click_on "Editar Cliente"
    select 'usuario2', from: 'cliente_user_id'
    click_on "Actualizar Cliente"
    assert_text "El Cliente se actualizó exitosamente"
  end

  test "asignar cliente nuevo a usuario" do
    visit clientes_url
    click_on "Nuevo Cliente"
    fill_in with: "632", id: 'cliente_num_interno'
    fill_in with: "EMPRESA ASIGNADA SA DE CV", id: 'cliente_razon_social'
    fill_in with: "EMP999999TU2", id: 'cliente_rfc'
    select 'usuario1', from: 'cliente_user_id'
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

end
