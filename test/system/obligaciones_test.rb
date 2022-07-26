require "application_system_test_case"

class ObligacionesTest < ApplicationSystemTestCase
  setup do
    @obligacion = obligaciones(:one)
    @usuario_asignado = @obligacion.cliente.user
    crear_y_entrar_como_usuario_system_test(@usuario_asignado.nombre_usuario,'testpassword',false)
  end

  test "visiting the index" do
    visit cliente_obligaciones_url(@obligacion.cliente)
    assert_selector "h3", text: "Obligaciones Presentadas de " + @obligacion.cliente.razon_social
  end

  test "should create obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Nueva obligacion"

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

  test "should destroy Obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first
    click_on "Eliminar" 

    assert_text "Se eliminó la obligación correctamente"
  end

end
