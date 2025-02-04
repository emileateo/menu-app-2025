# frozen_string_literal: true

module Types
  class MenuType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String
    field :label, String
    field :state, String
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
    field :menu_sections, [ Types::MenuSectionType ], null: false
    field :sections, [ Types::SectionType ], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
