# frozen_string_literal: true

module Types
  class SectionType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String
    field :label, String
    field :description, String
    field :items, [ Types::ItemType ], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
