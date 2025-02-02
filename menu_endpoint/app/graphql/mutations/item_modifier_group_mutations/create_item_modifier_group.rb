# frozen_string_literal: true

module Mutations
  module ItemModifierGroupMutations
    class CreateItemModifierGroup < BaseMutation
      description "Links a ModifierGroup to an Item"

      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true

      def resolve(item_id:, modifier_group_id:)
        item_modifier_group = ItemModifierGroup.create!(
          item_id: item_id,
          modifier_group_id: modifier_group_id,
        )

        item_modifier_group
      end
    end
  end
end
