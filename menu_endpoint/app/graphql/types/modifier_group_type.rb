# frozen_string_literal: true

module Types
  class ModifierGroupType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String
    field :label, String
    field :selection_required_min, Integer
    field :selection_required_max, Integer
    field :modifiers, [ Types::ModifierType ], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
