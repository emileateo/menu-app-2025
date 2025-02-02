require "test_helper"

class ModifierGroupTest < ActiveSupport::TestCase
  def setup
    @modifier_group = ModifierGroup.new(
      identifier: "toppings",
      label: "Choose your toppings",
      selection_required_min: 1,
      selection_required_max: 3
    )
  end

  test "should be valid with valid attributes" do
    assert @modifier_group.valid?
  end

  test "should require an identifier" do
    @modifier_group.identifier = nil
    assert_not @modifier_group.valid?
    assert_includes @modifier_group.errors[:identifier], "can't be blank"
  end

  test "should require a label" do
    @modifier_group.label = nil
    assert_not @modifier_group.valid?
    assert_includes @modifier_group.errors[:label], "can't be blank"
  end

  test "selection_required_min cannot be greater than selection_required_max" do
    @modifier_group.selection_required_min = 2
    @modifier_group.selection_required_max = 1
    assert_not @modifier_group.valid?
    assert_includes @modifier_group.errors[:selection_required_max].first, "must be more than or equal to selection_required_min"
  end
end
