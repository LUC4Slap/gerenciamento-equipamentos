require "application_system_test_case"

class EquipamentosTest < ApplicationSystemTestCase
  setup do
    @equipamento = equipamentos(:one)
  end

  test "visiting the index" do
    visit equipamentos_url
    assert_selector "h1", text: "Equipamentos"
  end

  test "should create equipamento" do
    visit equipamentos_url
    click_on "New equipamento"

    click_on "Create Equipamento"

    assert_text "Equipamento was successfully created"
    click_on "Back"
  end

  test "should update Equipamento" do
    visit equipamento_url(@equipamento)
    click_on "Edit this equipamento", match: :first

    click_on "Update Equipamento"

    assert_text "Equipamento was successfully updated"
    click_on "Back"
  end

  test "should destroy Equipamento" do
    visit equipamento_url(@equipamento)
    click_on "Destroy this equipamento", match: :first

    assert_text "Equipamento was successfully destroyed"
  end
end
