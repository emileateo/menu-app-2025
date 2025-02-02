# frozen_string_literal: true

module Mutations
  module ItemModifierGroupMutations
    class DeleteItemModifierGroup < BaseMutation
      description "Deletes a ItemModifierGroup by ID"

      argument :id, ID, required: true, description: "ID of the ItemModifierGroup to delete"

      field :id, ID, null: false, description: "ID of the deleted ItemModifierGroup"

      def resolve(id:)
        item_modifier_group = ItemModifierGroup.find(id)
        item_modifier_group.destroy!

        { id: id }
      end
    end
  end
end
