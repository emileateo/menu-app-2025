# frozen_string_literal: true

module Mutations
  module ItemMutations
    class UpdateItem < BaseMutation
      description "Updates an existing item"

      argument :id, ID, required: true
      argument :type, String, required: false
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :description, String, required: false
      argument :price, Float, required: false

      def resolve(id:, **attributes)
        item = Item.find(id)
        item.update!(attributes)

        item
      end
    end
  end
end
