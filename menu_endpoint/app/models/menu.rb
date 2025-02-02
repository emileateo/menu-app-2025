class Menu < ApplicationRecord
    has_many :menu_sections
    has_many :sections, through: :menu_sections

    STATES = %w[active inactive archived].freeze

    validates :state, presence: true, inclusion: { in: STATES, message: "%{value} is not a valid state" }
    validates :identifier, :label, presence: true
    validate :end_date_is_after_start_date

    def end_date_is_after_start_date
        return if end_date.blank?

        if end_date < start_date
          errors.add(:end_date, "must not be before start date")
        end
      end
end
