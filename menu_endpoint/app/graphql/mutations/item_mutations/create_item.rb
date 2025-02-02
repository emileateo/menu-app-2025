# frozen_string_literal: true

module Mutations
  module ItemMutations
    class CreateItem < BaseMutation
      description "Creates a new item"

      argument :type, String, required: true
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :description, String, required: true
      argument :price, Float, required: true

      def resolve(type:, identifier:, label:, description:, price:)
        item = Item.create!(
          type: type,
          identifier: identifier,
          label: label,
          description: description,
          price: price
        )

        item
      end
    end
  end
end
