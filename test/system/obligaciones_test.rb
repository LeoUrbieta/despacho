require "application_system_test_case"

class ObligacionesTest < ApplicationSystemTestCase
  setup do
    @obligacion = obligaciones(:one)
  end

  test "visiting the index" do
    visit obligaciones_url
    assert_selector "h1", text: "Obligaciones"
  end

  test "should create obligacion" do
    visit obligaciones_url
    click_on "New obligacion"

    fill_in "Annum", with: @obligacion.annum
    fill_in "Mes", with: @obligacion.mes
    fill_in "Obligaciones", with: @obligacion.presentadas
    click_on "Create Obligacion"

    assert_text "Obligacion was successfully created"
    click_on "Back"
  end

  test "should update Obligacion" do
    visit obligacion_url(@obligacion)
    click_on "Edit this obligacion", match: :first

    fill_in "Annum", with: @obligacion.annum
    fill_in "Mes", with: @obligacion.mes
    fill_in "Obligaciones", with: @obligacion.presentadas
    click_on "Update Obligacion"

    assert_text "Obligacion was successfully updated"
    click_on "Back"
  end

  test "should destroy Obligacion" do
    visit obligacion_url(@obligacion)
    click_on "Destroy this obligacion", match: :first

    assert_text "Obligacion was successfully destroyed"
  end
end
