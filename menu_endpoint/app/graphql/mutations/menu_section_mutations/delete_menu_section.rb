# frozen_string_literal: true

module Mutations
  module MenuSectionMutations
    class DeleteMenuSection < BaseMutation
      description "Deletes a MenuSection by ID"

      argument :id, ID, required: true, description: "ID of the MenuSection to delete"

      field :id, ID, null: false, description: "ID of the deleted MenuSection"

      def resolve(id:)
        menu_section = MenuSection.find(id)
        menu_section.destroy!

        { id: id }
      end
    end
  end
end
