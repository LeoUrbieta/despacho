require "application_system_test_case"

class ObligacionesTest < ApplicationSystemTestCase
  setup do
    @obligacion = obligaciones(:one)
    @usuario_asignado = @obligacion.cliente.user
    @mes_seleccionado_nueva_obligacion = Time.now - 1.month

    # Obligacion dos y tres estan asignadas a cliente(:two) que a su vez
    # estan asignadas a user(:three)
    # Obligacion tres tiene Fecha Enero 2022
    @obligacion_dos = obligaciones(:two)
    @usuario_asignado_tres = @obligacion_dos.cliente.user

    entrar_como_usuario_system_test(@usuario_asignado.nombre_usuario,'testpassword4')
  end

  test "visiting the index" do
    visit cliente_obligaciones_url(@obligacion.cliente)
    assert_selector "h3", text: "Obligaciones Presentadas de " + @obligacion.cliente.razon_social
  end

  test "should create obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_on "Añadir obligacion", match: :first

    select 'Enero', from: 'obligacion_fecha_2i' 
    select '2022', from: 'obligacion_fecha_1i' 
    first('input[type="checkbox"]').check
    click_on "Crear Obligacion"

    assert_text @obligacion.cliente.razon_social
    assert_text "La Obligacion se creó exitosamente"
  end

  test "should update Obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first

    select 'Diciembre', from: 'obligacion_fecha_2i' 
    select '2022', from: 'obligacion_fecha_1i' 
    click_on "Actualizar Obligacion"

    assert_text "La obligación se actualizó exitosamente"
    assert_text @obligacion.cliente.razon_social
  end

  test "select in new obligacion must have previous month" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_on "Añadir obligacion"
    assert_select 'obligacion_fecha_2i', selected: I18n.t(@mes_seleccionado_nueva_obligacion.strftime('%B'))
  end

  test "select in edit obligacion must have month of said obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first
    assert_select 'obligacion_fecha_2i', selected: I18n.t(@obligacion.fecha.strftime('%B'))
  end

  test "should not update obligacion if another one exists with same date and belongs to same cliente" do
    click_on "Terminar Sesion"
    entrar_como_usuario_system_test(@usuario_asignado_tres.nombre_usuario,'testpassword3')
    click_on "Contabilidad"
    assert_text @obligacion_dos.cliente.razon_social
    click_link @obligacion_dos.cliente.razon_social
    click_link "Editar", href: "/clientes/#{@obligacion_dos.cliente.id}/obligaciones/#{@obligacion_dos.id}/edit"
    select "Enero", from: 'obligacion_fecha_2i'
    select "2022", from: 'obligacion_fecha_1i'
    click_on 'Actualizar Obligacion'
    assert_text 'Fecha ya ha sido tomado'
  end

  test "should destroy Obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first
    click_on "Eliminar" 

    assert_text "Se eliminó la obligación correctamente"
  end

end
