# frozen_string_literal: true

module Mutations
  module ItemModifierGroupMutations
    class UpdateItemModifierGroup < BaseMutation
      description "Updates an existing ItemModifierGroup"

      argument :id, ID, required: true
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true

      def resolve(id:, **attributes)
        item_modifier_group = ItemModifierGroup.find(id)
        item_modifier_group.update!(attributes)

        item_modifier_group
      end
    end
  end
end
