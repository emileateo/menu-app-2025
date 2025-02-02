# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_menu, Types::MenuType, mutation: Mutations::MenuMutations::CreateMenu
    field :update_menu, Types::MenuType, mutation: Mutations::MenuMutations::UpdateMenu
    field :delete_menu, mutation: Mutations::MenuMutations::DeleteMenu

    field :create_section, Types::SectionType, mutation: Mutations::SectionMutations::CreateSection
    field :update_section, Types::SectionType, mutation: Mutations::SectionMutations::UpdateSection
    field :delete_section, mutation: Mutations::SectionMutations::DeleteSection

    field :create_item, Types::ItemType, mutation: Mutations::ItemMutations::CreateItem
    field :update_item, Types::ItemType, mutation: Mutations::ItemMutations::UpdateItem
    field :delete_item, mutation: Mutations::ItemMutations::DeleteItem

    field :create_modifier_group, Types::ModifierGroupType, mutation: Mutations::ModifierGroupMutations::CreateModifierGroup
    field :update_modifier_group, Types::ModifierGroupType, mutation: Mutations::ModifierGroupMutations::UpdateModifierGroup
    field :delete_modifier_group, mutation: Mutations::ModifierGroupMutations::DeleteModifierGroup

    field :create_modifier, Types::ModifierType, mutation: Mutations::ModifierMutations::CreateModifier
    field :update_modifier, Types::ModifierType, mutation: Mutations::ModifierMutations::UpdateModifier
    field :delete_modifier, mutation: Mutations::ModifierMutations::DeleteModifier

    field :create_menu_section, Types::MenuSectionType, mutation: Mutations::MenuSectionMutations::CreateMenuSection
    field :update_menu_section, Types::MenuSectionType, mutation: Mutations::MenuSectionMutations::UpdateMenuSection
    field :delete_menu_section, mutation: Mutations::MenuSectionMutations::DeleteMenuSection

    field :create_section_item, Types::SectionItemType, mutation: Mutations::SectionItemMutations::CreateSectionItem
    field :update_section_item, Types::SectionItemType, mutation: Mutations::SectionItemMutations::UpdateSectionItem
    field :delete_section_item, mutation: Mutations::SectionItemMutations::DeleteSectionItem

    field :create_item_modifier_group, Types::ItemModifierGroupType, mutation: Mutations::ItemModifierGroupMutations::CreateItemModifierGroup
    field :update_item_modifier_group, Types::ItemModifierGroupType, mutation: Mutations::ItemModifierGroupMutations::UpdateItemModifierGroup
    field :delete_item_modifier_group, mutation: Mutations::ItemModifierGroupMutations::DeleteItemModifierGroup
  end
end
