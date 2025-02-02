# frozen_string_literal: true

module Mutations
  module ModifierGroupMutations
    class UpdateModifierGroup < BaseMutation
      description "Updates an existing modifier group"

      argument :id, ID, required: true
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :selection_required_min, Integer, required: false
      argument :selection_required_max, Integer, required: false

      def resolve(id:, **attributes)
        modifier_group = ModifierGroup.find(id)
        modifier_group.update!(attributes)

        modifier_group
      end
    end
  end
end
