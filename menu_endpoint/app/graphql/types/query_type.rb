# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :menu, Types::MenuType, null: true, description: "Fetches a menu given its ID" do
      argument :id, ID, required: true, description: "ID of the menu"
    end

    field :menus, [ Types::MenuType, null: true ], null: true, description: "Fetches a list of menus given a list of IDs" do
      argument :ids, [ ID ], required: false, description: "IDs of the menus (leave blank to return all)"
    end

    field :section, Types::SectionType, null: true, description: "Fetches a section given its ID" do
      argument :id, ID, required: true, description: "ID of the section"
    end

    field :sections, [ Types::SectionType ], null: true, description: "Fetches a list of sections given a list of IDs" do
      argument :ids, [ ID ], required: false, description: "IDs of the sections (leave blank to return all)"
    end

    field :item, Types::ItemType, null: true, description: "Fetches an item given its ID." do
      argument :id, ID, required: true, description: "ID of the item."
    end

    field :items, [ Types::ItemType ], null: true, description: "Fetches a list of items given a list of IDs or types (leave blank to return all)" do
      argument :ids, [ ID ], required: false, description: "IDs of the items"
      argument :type, ID, required: false, description: "Filter by type of items"
    end

    field :modifier_group, Types::ModifierGroupType, null: true, description: "Fetches a modifier group given its ID" do
      argument :id, ID, required: true, description: "ID of the modifier group"
    end

    field :modifier_groups, [ Types::ModifierGroupType ], null: true, description: "Fetches a list of modifier groups given a list of IDs" do
      argument :ids, [ ID ], required: false, description: "IDs of the modifier groups (leave blank to return all)"
    end

    field :modifier, Types::ModifierType, null: true, description: "Fetches a modifier given its ID" do
      argument :id, ID, required: true, description: "ID of the modifier"
    end

    field :modifiers, [ Types::ModifierType ], null: true, description: "Fetches a list of modifiers given a list of IDs" do
      argument :ids, [ ID ], required: false, description: "IDs of the modifiers (leave blank to return all)"
    end

    def menu(id:)
      Menu.find(id)
    end

    def menus(ids: [])
      if ids.present?
        ids.map { |id| Menu.find(id) }.compact
      else
        Menu.all
      end
    end

    def section(id:)
      Section.find(id)
    end

    def sections(ids: [])
      if ids.present?
        ids.map { |id| Section.find(id) }.compact
      else
        Section.all
      end
    end

    def item(id:)
      Item.find(id)
    end

    def items(ids: [], type: nil)
      items = Item.all
      items = items.where(id: ids) if ids.present?
      items = items.where(type: type) if type.present?

      items
    end

    def modifier_group(id:)
      ModifierGroup.find(id)
    end

    def modifier_groups(ids: [])
      if ids.present?
        ids.map { |id| ModifierGroup.find(id) }.compact
      else
        ModifierGroup.all
      end
    end

    def modifier(id:)
      Modifier.find(id)
    end

    def modifiers(ids: [])
      if ids.present?
        ids.map { |id| Modifier.find(id) }.compact
      else
        Modifier.all
      end
    end
  end
end
