# frozen_string_literal: true

module Types
  class SectionType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String
    field :label, String
    field :description, String
    field :is_available, Boolean, null: false
    field :section_items, [ Types::SectionItemType ], null: false
    field :items, [ Types::ItemType ], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
