# frozen_string_literal: true

module Mutations
  module SectionMutations
    class UpdateSection < BaseMutation
      description "Updates an existing section"

      argument :id, ID, required: true
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :description, String, required: false

      def resolve(id:, **attributes)
        section = Section.find(id)
        section.update!(attributes)

        section
      end
    end
  end
end
