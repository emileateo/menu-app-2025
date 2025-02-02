class AddAvailabilityToSectionsAndItems < ActiveRecord::Migration[8.0]
  def change
    add_column :sections, :is_available, :boolean, default: true
    add_column :items, :available_quantity, :integer, default: 1
  end
end
