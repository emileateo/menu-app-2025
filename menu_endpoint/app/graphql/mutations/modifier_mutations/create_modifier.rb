# frozen_string_literal: true

module Mutations
  module ModifierMutations
    class CreateModifier < BaseMutation
      description "Creates a new modifier"

      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true
      argument :display_order, Integer, required: false, default_value: 0
      argument :default_quantity, Integer, required: false, default_value: 0
      argument :price_override, Float, required: true

      def resolve(item_id:, modifier_group_id:, display_order:, default_quantity:, price_override:)
        modifier = Modifier.create!(
          item_id: item_id,
          modifier_group_id: modifier_group_id,
          display_order: display_order,
          default_quantity: default_quantity,
          price_override: price_override
        )

        modifier
      end
    end
  end
end
