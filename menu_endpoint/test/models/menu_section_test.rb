require "test_helper"

class MenuSectionTest < ActiveSupport::TestCase
  def setup
    @menu = Menu.new(
      identifier: "test_menu",
      label: "Test Menu",
      state: "active",
      start_date: Date.today,
      end_date: Date.today + 7.days
    )

    @section = Section.new(
      identifier: "starters",
      label: "Starters",
      description: "Appetizers and small plates"
    )

    @menu_section = MenuSection.new(
      menu: @menu,
      section: @section,
      display_order: 1,
    )
  end

  test "should be valid with valid attributes" do
    assert @menu_section.valid?
  end

  test "should require a menu" do
    @menu_section.menu = nil
    assert_not @menu_section.valid?
    assert_includes @menu_section.errors[:menu], "must exist"
  end

  test "should require a section" do
    @menu_section.section = nil
    assert_not @menu_section.valid?
    assert_includes @menu_section.errors[:section], "must exist"
  end
end
