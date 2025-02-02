require "test_helper"

class MenuTest < ActiveSupport::TestCase
  def setup
    @menu = Menu.new(
      identifier: "test_menu",
      label: "Test Menu",
      state: "active",
      start_date: Date.today,
      end_date: Date.today + 7.days
    )
  end

  test "should be valid with valid attributes" do
    assert @menu.valid?
  end

  test "should require an identifier" do
    @menu.identifier = nil
    assert_not @menu.valid?
    assert_includes @menu.errors[:identifier], "can't be blank"
  end

  test "should require a label" do
    @menu.label = nil
    assert_not @menu.valid?
    assert_includes @menu.errors[:label], "can't be blank"
  end

  test "should have a valid state" do
    @menu.state = "invalid_state"
    assert_not @menu.valid?
    assert_includes @menu.errors[:state].first, "is not a valid state"
  end

  test "start_date should not be after end_date" do
    @menu.end_date = Date.today - 1.day
    assert_not @menu.valid?
    assert_includes @menu.errors[:end_date], "must not be before start date"
  end
end
