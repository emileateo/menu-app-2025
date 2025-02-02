# frozen_string_literal: true

module Mutations
  module ModifierMutations
    class UpdateModifier < BaseMutation
      description "Updates an existing modifier"

      argument :id, ID, required: true
      argument :item_id, ID, required: false
      argument :modifier_group_id, ID, required: false
      argument :display_order, Integer, required: false, default_value: 0
      argument :default_quantity, Integer, required: false, default_value: 0
      argument :price_override, Float, required: false

      def resolve(id:, **attributes)
        modifier = Modifier.find(id)
        modifier.update!(attributes)

        modifier
      end
    end
  end
end
