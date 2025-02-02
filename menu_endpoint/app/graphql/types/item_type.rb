# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :type, String
    field :identifier, String
    field :label, String
    field :description, String
    field :price, Float
    field :available_quantity, Integer, null: false
    field :modifier_groups, [ Types::ModifierGroupType ], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
