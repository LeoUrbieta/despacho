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

    entrar_como_usuario_system_test(@usuario_asignado.nombre_usuario, "testpassword4")
  end

  test "visiting the index" do
    visit cliente_obligaciones_url(@obligacion.cliente)
    assert_selector "h3", text: "Obligaciones Presentadas de " + @obligacion.cliente.razon_social
  end

  test "should create obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    assert_select "obligacion_fecha_2i", selected: I18n.t(@mes_seleccionado_nueva_obligacion.strftime("%B"))
    assert_select "obligacion_fecha_1i", selected: @mes_seleccionado_nueva_obligacion.strftime("%Y")
    click_on "Presentado", match: :first

    assert_text I18n.t(@mes_seleccionado_nueva_obligacion.strftime("%B")), count: 2
    # 2 veces ya que debe aparecer en texto de Última Obligacion presentada y en el Select
    assert_text @mes_seleccionado_nueva_obligacion.strftime("%Y"), count: 2
  end

  test "should update Obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first

    select "Diciembre", from: "obligacion_fecha_2i"
    select "2022", from: "obligacion_fecha_1i"
    click_on "Actualizar Obligacion"

    assert_text "La obligación se actualizó exitosamente"
    assert_text @obligacion.cliente.razon_social
  end

  test "select in new obligacion must have previous month" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    assert_select "obligacion_fecha_2i", selected: I18n.t(@mes_seleccionado_nueva_obligacion.strftime("%B"))
  end

  test "select in edit obligacion must have month of said obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first
    assert_select "obligacion_fecha_2i", selected: I18n.t(@obligacion.fecha.strftime("%B"))
  end

  test "should not update obligacion if another one exists with same date and belongs to same cliente" do
    click_on "Terminar Sesion"
    entrar_como_usuario_system_test(@usuario_asignado_tres.nombre_usuario, "testpassword3")
    click_on "Contabilidad"
    assert_text @obligacion_dos.cliente.razon_social
    click_link @obligacion_dos.cliente.razon_social
    click_link "Editar", href: "/clientes/#{@obligacion_dos.cliente.id}/obligaciones/#{@obligacion_dos.id}/edit"
    select "Enero", from: "obligacion_fecha_2i"
    select "2022", from: "obligacion_fecha_1i"
    click_on "Actualizar Obligacion"
    assert_text "Fecha ya ha sido tomado"
  end

  test "should destroy Obligacion" do
    click_on "Contabilidad"
    assert_text @obligacion.cliente.razon_social
    click_link @obligacion.cliente.razon_social
    click_on "Editar", match: :first
    click_on "Eliminar"

    assert_text "Se eliminó la obligación correctamente"
  end

  test "when another user selected creating obligacion should turbo stream to this user" do
    click_on "Contabilidad"
    select @usuario_asignado_tres.nombre_usuario, from: "id"
    click_on "Cambiar"
    assert_text @usuario_asignado_tres.clientes.first.razon_social
    click_on "Presentado", match: :first
    assert_select "id", selected: @usuario_asignado_tres.nombre_usuario
    assert_text @usuario_asignado_tres.clientes.first.razon_social
  end

  test "if cliente asignado no se presenta contabilidad debe haber boton de no presentar" do
    click_on "Contabilidad"
    select @usuario_asignado_tres.nombre_usuario, from: "id"
    click_on "Cambiar"
    assert_text @usuario_asignado_tres.clientes.first.razon_social
    nombre_cliente_que_no_se_presenta_contabilidad =
      @usuario_asignado_tres.clientes.where("presentar_contabilidad = FALSE").first.razon_social
    fila_cliente_cuya_contabilidad_no_se_presenta =
      find("tr", text: nombre_cliente_que_no_se_presenta_contabilidad)
    within fila_cliente_cuya_contabilidad_no_se_presenta do
      find("td", text: "No presentar")
    end
  end
end
