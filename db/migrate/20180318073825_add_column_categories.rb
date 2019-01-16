class AddColumnCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :title_image, :string
    add_column :categories, :icon_image, :string
  end
end
