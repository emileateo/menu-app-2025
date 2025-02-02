# frozen_string_literal: true

module Mutations
  module MenuSectionMutations
    class CreateMenuSection < BaseMutation
      description "Links a Section to Menu"

      argument :menu_id, ID, required: true
      argument :section_id, ID, required: true
      argument :display_order, Integer, required: false, default_value: 0

      def resolve(menu_id:, section_id:, display_order:)
        menu_section = MenuSection.create!(
          menu_id: menu_id,
          section_id: section_id,
          display_order: display_order
        )

        menu_section
      end
    end
  end
end
