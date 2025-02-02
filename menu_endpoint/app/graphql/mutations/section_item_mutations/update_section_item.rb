# frozen_string_literal: true

module Mutations
  module SectionItemMutations
    class UpdateSectionItem < BaseMutation
      description "Updates an existing SectionItem"

      argument :id, ID, required: true
      argument :section_id, ID, required: false
      argument :item_id, ID, required: false
      argument :display_order, Integer, required: false, default_value: 0

      def resolve(id:, **attributes)
        section_item = SectionItem.find(id)
        section_item.update!(attributes)

        section_item
      end
    end
  end
end
