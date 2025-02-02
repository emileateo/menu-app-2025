# frozen_string_literal: true

module Mutations
  module SectionItemMutations
    class DeleteSectionItem < BaseMutation
      description "Deletes a SectionItem by ID"

      argument :id, ID, required: true, description: "ID of the SectionItem to delete"

      field :id, ID, null: false, description: "ID of the deleted SectionItem"

      def resolve(id:)
        section_item = SectionItem.find(id)
        section_item.destroy!

        { id: id }
      end
    end
  end
end
