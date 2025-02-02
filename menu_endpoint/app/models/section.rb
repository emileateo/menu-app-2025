class Section < ApplicationRecord
    has_many :section_items
    has_many :items, through: :section_items

    validates :identifier, :label, presence: true
end
