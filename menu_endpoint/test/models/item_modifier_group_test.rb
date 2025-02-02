require "test_helper"

class ItemModifierGroupTest < ActiveSupport::TestCase
  def setup
    @item = Product.create(
      identifier: "salad",
      label: "Salad",
      description: "Fresh garden salad",
      price: 10.50
    )

    @modifier_group = ModifierGroup.new(
      identifier: "toppings",
      label: "Choose your toppings",
      selection_required_min: 0,
      selection_required_max: 3
    )

    @item_modifier_group = ItemModifierGroup.new(
      item: @item,
      modifier_group: @modifier_group
    )
  end

  test "should be valid with valid attributes" do
    assert @item_modifier_group.valid?
  end

  test "should require an item" do
    @item_modifier_group.item = nil
    assert_not @item_modifier_group.valid?
    assert_includes @item_modifier_group.errors[:item], "must exist"
  end

  test "should require a modifier group" do
    @item_modifier_group.modifier_group = nil
    assert_not @item_modifier_group.valid?
    assert_includes @item_modifier_group.errors[:modifier_group], "must exist"
  end
end
