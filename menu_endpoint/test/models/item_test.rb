require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def setup
    @product_item = Product.create(
      identifier: "salad",
      label: "Salad",
      description: "Fresh garden salad",
      price: 10.50
    )
  end

  test "should be valid with valid attributes" do
    assert @product_item.valid?
  end

  test "should require a type" do
    @product_item.type = nil
    assert_not @product_item.valid?
    assert_includes @product_item.errors[:type], "can't be blank"
  end

  test "should require an identifier" do
    @product_item.identifier = nil
    assert_not @product_item.valid?
    assert_includes @product_item.errors[:identifier], "can't be blank"
  end

  test "price should be a positive number" do
    @product_item.price = -5
    assert_not @product_item.valid?
    assert_includes @product_item.errors[:price], "must be greater than or equal to 0"
  end
end
