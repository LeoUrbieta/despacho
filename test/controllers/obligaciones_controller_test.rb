require "test_helper"

class ObligacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @obligacion = obligaciones(:one)
  end

  test "should get index" do
    get obligaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_obligacion_url
    assert_response :success
  end

  test "should create obligacion" do
    assert_difference("Obligacion.count") do
      post obligaciones_url, params: { obligacion: { annum: @obligacion.annum, mes: @obligacion.mes, obligaciones: @obligacion.presentadas} }
    end

    assert_redirected_to obligacion_url(Obligacion.last)
  end

  test "should show obligacion" do
    get obligacion_url(@obligacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_obligacion_url(@obligacion)
    assert_response :success
  end

  test "should update obligacion" do
    patch obligacion_url(@obligacion), params: { obligacion: { annum: @obligacion.annum, mes: @obligacion.mes, obligaciones: @obligacion.presentadas } }
    assert_redirected_to obligacion_url(@obligacion)
  end

  test "should destroy obligacion" do
    assert_difference("Obligacion.count", -1) do
      delete obligacion_url(@obligacion)
    end

    assert_redirected_to obligaciones_url
  end
end
