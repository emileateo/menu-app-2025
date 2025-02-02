# frozen_string_literal: true

module Mutations
  module MenuMutations
    class DeleteMenu < BaseMutation
      description "Deletes a menu by ID"

      argument :id, ID, required: true, description: "ID of the menu to delete"

      field :id, ID, null: false, description: "ID of the deleted menu"

      def resolve(id:)
        menu = Menu.find(id)
        menu.destroy!

        { id: id }
      end
    end
  end
end
