# frozen_string_literal: true

module Mutations
  module ModifierGroupMutations
    class CreateModifierGroup < BaseMutation
      description "Creates a new modifier group"

      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :selection_required_min, Integer, required: true
      argument :selection_required_max, Integer, required: true

      def resolve(identifier:, label:, selection_required_min:, selection_required_max:)
        modifier_group = ModifierGroup.create!(
          identifier: identifier,
          label: label,
          selection_required_min: selection_required_min,
          selection_required_max: selection_required_max
        )

        modifier_group
      end
    end
  end
end
