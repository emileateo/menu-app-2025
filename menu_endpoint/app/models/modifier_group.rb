class ModifierGroup < ApplicationRecord
    has_many :modifiers
    validates :identifier, :label, :selection_required_min, presence: true

    validates :selection_required_max, comparison: { greater_than_or_equal_to: :selection_required_min, message: "%{value} must be more than or equal to selection_required_min"  }
end
