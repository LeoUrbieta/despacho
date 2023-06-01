require "application_system_test_case"

class ReplegalesTest < ApplicationSystemTestCase
  setup do
    @adrian_jimenez = replegales(:one)
    @empresa_sin_replegal = clientes(:empresa_sin_replegal) 
    crear_y_entrar_como_usuario_system_test('user_rep_legal','user12345',false,false)
  end

  test "visiting the index" do
    visit replegales_url
    assert_selector "h1", text: "Representantes Legales"
  end

  test "creating a Replegal" do
    visit replegales_url
    click_on "Nuevo Representante Legal"
    nombre = "MARIANO MATAMOROES"
    fill_in with: nombre, id: 'replegal_nombre_completo'
    fill_in with: "MAMO991011DFA", id: 'replegal_rfc'
    first('input[type="checkbox"]').check
    nombre_empresa = first('label[class="form-check-label"]').text
    click_on "Crear Replegal"
    assert_text "El Representante legal se creó correctamente"
    assert_text nombre
    assert_text nombre_empresa
  end

  test "create a replegal from lista clientes" do
    visit replegales_url
    click_link "Nuevo Representante Legal"
    assert_selector('select#replegal_cliente_ids')
    select('JIMENA CANTU',from: 'replegal_cliente_ids')
    find('input[value="Crear Replegal"]').click
    assert_text("El Representante legal se creó correctamente")
    assert_text("Asociado al Cliente: 110 - JIMENA CANTU")
  end

  test "updating a Replegal which is not in Clientes list" do
    visit replegales_url
    find('.table').find('a',text: replegales(:not_in_clientes_list).nombre_completo).click
    assert_text replegales(:not_in_clientes_list).nombre_completo
    assert_link "Editar Rep. Legal"
    click_link "Editar Rep. Legal"
    nombre_nuevo = "JERONIMO AGUILAR"
    fill_in with: nombre_nuevo, id: 'replegal_nombre_completo'
    click_on "Actualizar Replegal"
    assert_text "El representante legal se actualizó correctamente"
    assert_text nombre_nuevo
  end

  test "update replegal which is in clientes list" do
    visit replegales_url
    assert_text "AMADO NERVO"
    click_link "AMADO NERVO"
    click_link "Editar Rep. Legal"
    assert_no_selector('select#replegal_cliente_ids')
    all('input[type="checkbox"]').each do |checkbox|
      assert_not checkbox.checked?
    end
    assert_link "Ir al perfil del Cliente"
    find('input[value="' + @empresa_sin_replegal.id.to_s + '"]').check
    find('input[value="Actualizar Replegal"]').click
    assert_text "Asociado al Cliente: 104 - AMADO NERVO" 
    assert_text @empresa_sin_replegal.num_interno.to_s + " - " + @empresa_sin_replegal.razon_social
  end

  test "remover asignacion de empresa a replegal" do
    visit replegal_path(@adrian_jimenez)
    assert_selector('div', text: 'ADRIAN JIMENEZ CORP SA DE CV')
    click_link "Editar Rep. Legal"
    assert_selector('label', text: 'ADRIAN JIMENEZ CORP SA DE CV')
    id_empresa = @adrian_jimenez.clientes.find_by(rfc: "JIAC761113ZV1").id.to_s
    empresa_actualmente_asignada = find('input[value="' + id_empresa  + '"]')
    assert empresa_actualmente_asignada.checked?
    empresa_actualmente_asignada.uncheck
    find('input[value="Actualizar Replegal"]').click
    assert_text "El representante legal se actualizó correctamente"
    assert_no_selector('div', text: 'ADRIAN JIMENEZ CORP SA DE CV')
  end

  test "destroying a Replegal" do
    visit replegales_url
    assert_no_button "Eliminar"
    click_button "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test('user_admin','user12345',true,false)
    visit replegales_url
    find('.table').find('a',text: replegales(:one).nombre_completo).click
    assert_text replegales(:one).nombre_completo
    assert_button "Eliminar"
    click_button "Eliminar"
    assert_text "El representante legal se eliminó correctamente"
    assert_selector "h1", text: "Representantes Legales"
  end

  test "Mostrar boton a editar perfil de cliente si replegal ya esta en esa lista" do
    visit replegales_url
    assert_text "AMADO NERVO"
    click_link "AMADO NERVO"
    click_link "Editar Rep. Legal"
    assert_link "Ir al perfil del Cliente"
    click_link "Ir al perfil del Cliente"
    assert_text "Editar Cliente"
  end

  test "al crear replegal y elegir dos clientes de lista debe haber error" do
    visit replegales_url
    click_link "Nuevo Representante Legal"
    assert_selector('select#replegal_cliente_ids')
    select('JIMENA CANTU',from: 'replegal_cliente_ids')
    select('JAVIER IBARGUENGOITIA', from: 'replegal_cliente_ids')
    find('input[value="Crear Replegal"]').click
    assert_text("1 error")
    assert_text("Un representante legal solo puede estar asociado a una persona física")
  end
end
