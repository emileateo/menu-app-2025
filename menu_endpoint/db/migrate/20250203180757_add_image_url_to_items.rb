class AddImageUrlToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :image_url, :string
  end
end
