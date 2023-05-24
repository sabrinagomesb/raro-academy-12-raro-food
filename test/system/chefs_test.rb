require "application_system_test_case"

class ChefsTest < ApplicationSystemTestCase
  setup do
    @chef = chefs(:one)
  end

  test "visiting the index" do
    visit chefs_url
    assert_selector "h1", text: "Chefs"
  end

  test "should create chef" do
    visit chefs_url
    click_on "New chef"

    click_on "Create Chef"

    assert_text "Chef was successfully created"
    click_on "Back"
  end

  test "should update Chef" do
    visit chef_url(@chef)
    click_on "Edit this chef", match: :first

    click_on "Update Chef"

    assert_text "Chef was successfully updated"
    click_on "Back"
  end

  test "should destroy Chef" do
    visit chef_url(@chef)
    click_on "Destroy this chef", match: :first

    assert_text "Chef was successfully destroyed"
  end
end
