# frozen_string_literal: true

module Mutations
  module MenuMutations
    class CreateMenu < BaseMutation
      description "Creates a new menu"

      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :state, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: false

      def resolve(identifier:, label:, state:, start_date:, end_date: nil)
        menu = Menu.create!(
          identifier: identifier,
          label: label,
          state: state,
          start_date: start_date,
          end_date: end_date
        )

        menu
      end
    end
  end
end
