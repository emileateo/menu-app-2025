# frozen_string_literal: true

module Mutations
  module ModifierGroupMutations
    class DeleteModifierGroup < BaseMutation
      description "Deletes a modifier group by ID"

      argument :id, ID, required: true, description: "ID of the modifier group to delete"

      field :id, ID, null: false, description: "ID of the deleted modifier group"

      def resolve(id:)
        modifier_group = ModifierGroup.find(id)
        modifier_group.destroy!

        { id: id }
      end
    end
  end
end
