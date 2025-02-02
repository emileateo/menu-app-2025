# frozen_string_literal: true

module Mutations
  module ModifierMutations
    class DeleteModifier < BaseMutation
      description "Deletes a modifier by ID"

      argument :id, ID, required: true, description: "ID of the modifier to delete"

      field :id, ID, null: false, description: "ID of the deleted modifier"

      def resolve(id:)
        modifier = Modifier.find(id)
        modifier.destroy!

        { id: id }
      end
    end
  end
end
