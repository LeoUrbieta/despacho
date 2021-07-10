require "application_system_test_case"

class ReplegalesTest < ApplicationSystemTestCase
  setup do
    @replegal = replegales(:one)
  end

  test "visiting the index" do
    visit replegales_url
    assert_selector "h1", text: "Replegales"
  end

  test "creating a Replegal" do
    visit replegales_url
    click_on "New Replegal"

    click_on "Create Replegal"

    assert_text "Replegal was successfully created"
    click_on "Back"
  end

  test "updating a Replegal" do
    visit replegales_url
    click_on "Edit", match: :first

    click_on "Update Replegal"

    assert_text "Replegal was successfully updated"
    click_on "Back"
  end

  test "destroying a Replegal" do
    visit replegales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Replegal was successfully destroyed"
  end
end
