# frozen_string_literal: true

module Mutations
  module MenuMutations
    class UpdateMenu < BaseMutation
      description "Updates an existing menu"

      argument :id, ID, required: true
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :state, String, required: false
      argument :start_date, GraphQL::Types::ISO8601Date, required: false
      argument :end_date, GraphQL::Types::ISO8601Date, required: false

      def resolve(id:, **attributes)
        menu = Menu.find(id)
        menu.update!(attributes)

        menu
      end
    end
  end
end
