# frozen_string_literal: true

module Mutations
  module MenuSectionMutations
    class UpdateMenuSection < BaseMutation
      description "Updates an existing MenuSection"

      argument :id, ID, required: true
      argument :menu_id, ID, required: false
      argument :section_id, ID, required: false
      argument :display_order, Integer, required: false, default_value: 0

      def resolve(id:, **attributes)
        menu_section = MenuSection.find(id)
        menu_section.update!(attributes)

        menu_section
      end
    end
  end
end
