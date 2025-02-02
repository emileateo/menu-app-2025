# frozen_string_literal: true

module Mutations
  module SectionMutations
    class DeleteSection < BaseMutation
      description "Deletes a section by ID"

      argument :id, ID, required: true, description: "ID of the section to delete"

      field :id, ID, null: false, description: "ID of the deleted section"

      def resolve(id:)
        section = Section.find(id)
        section.destroy!

        { id: id }
      end
    end
  end
end
