class SectionItem < ApplicationRecord
  belongs_to :section
  belongs_to :item
  validates :display_order, presence: true
end
