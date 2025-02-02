require "test_helper"

class SectionItemTest < ActiveSupport::TestCase
  def setup
    @section = Section.new(
      identifier: "starters",
      label: "Starters",
      description: "Appetizers and small plates"
    )

    @item = Product.create(
      identifier: "salad",
      label: "Salad",
      description: "Fresh garden salad",
      price: 10.50
    )

    @section_item = SectionItem.new(
      section: @section,
      item: @item,
      display_order: 1,
    )
  end

  test "should be valid with valid attributes" do
    assert @section_item.valid?
  end

  test "should require a section" do
    @section_item.section = nil
    assert_not @section_item.valid?
    assert_includes @section_item.errors[:section], "must exist"
  end

  test "should require an item" do
    @section_item.item = nil
    assert_not @section_item.valid?
    assert_includes @section_item.errors[:item], "must exist"
  end
end
