# frozen_string_literal: true

module Mutations
  module SectionItemMutations
    class CreateSectionItem < BaseMutation
      description "Links an Item to a Section"

      argument :section_id, ID, required: true
      argument :item_id, ID, required: true
      argument :display_order, Integer, required: false, default_value: 0

      def resolve(section_id:, item_id:, display_order:)
        section_item = SectionItem.create!(
          section_id: section_id,
          item_id: item_id,
          display_order: display_order
        )

        section_item
      end
    end
  end
end
