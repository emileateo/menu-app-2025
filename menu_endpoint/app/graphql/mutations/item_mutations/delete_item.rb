# frozen_string_literal: true

module Mutations
  module ItemMutations
    class DeleteItem < BaseMutation
      description "Deletes a item by ID"

      argument :id, ID, required: true, description: "ID of the item to delete"

      field :id, ID, null: false, description: "ID of the deleted item"

      def resolve(id:)
        item = Item.find(id)
        item.destroy!

        { id: id }
      end
    end
  end
end
