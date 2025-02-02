# frozen_string_literal: true

module Mutations
  module SectionMutations
    class CreateSection < BaseMutation
      description "Creates a new section"

      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :description, String, required: true

      def resolve(identifier:, label:, description:)
        section = Section.create!(
          identifier: identifier,
          label: label,
          description: description
        )

        section
      end
    end
  end
end
