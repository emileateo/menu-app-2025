require "test_helper"

class SectionTest < ActiveSupport::TestCase
  def setup
    @section = Section.new(
      identifier: "starters",
      label: "Starters",
      description: "Appetizers and small plates"
    )
  end

  test "should be valid with valid attributes" do
    assert @section.valid?
  end

  test "should require an identifier" do
    @section.identifier = nil
    assert_not @section.valid?
    assert_includes @section.errors[:identifier], "can't be blank"
  end

  test "should require a label" do
    @section.label = nil
    assert_not @section.valid?
    assert_includes @section.errors[:label], "can't be blank"
  end
end
