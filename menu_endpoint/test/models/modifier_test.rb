require "test_helper"

class ModifierTest < ActiveSupport::TestCase
  def setup
    @component_item = Component.create(
      identifier: "croutons",
      label: "Croutons",
      description: "Add some crunch to your salad",
      price: 1.0
    )

    @modifier_group = ModifierGroup.create!(
      identifier: "toppings",
      label: "Toppings",
      selection_required_min: 0,
      selection_required_max: 3
    )

    @modifier = Modifier.new(
      item: @component_item,
      modifier_group: @modifier_group,
      display_order: 1,
      default_quantity: 0,
      price_override: 1.0
    )
  end

  test "should be valid with valid attributes" do
    assert @modifier.valid?
  end

  test "should require an item" do
    @modifier.item = nil
    assert_not @modifier.valid?
    assert_includes @modifier.errors[:item], "must exist"
  end

  test "should require a modifier group" do
    @modifier.modifier_group = nil
    assert_not @modifier.valid?
    assert_includes @modifier.errors[:modifier_group], "must exist"
  end
end
