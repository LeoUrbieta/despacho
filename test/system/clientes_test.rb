require "application_system_test_case"

class ClientesTest < ApplicationSystemTestCase
  setup do
    @cliente = clientes(:one)
    User.create!(nombre_usuario: 'leomoreno', password: 'leomoreno', admin: false)
    visit root_path
    fill_in with: 'leomoreno', id: 'session_nombre_usuario'
    fill_in with: 'leomoreno', :id => 'session_password'
    click_on "Entrar"
    assert_text "Has entrado con éxito"
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
end
