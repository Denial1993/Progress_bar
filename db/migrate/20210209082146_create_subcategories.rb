class CreateSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :description
      t.string :image_url
      #這邊是新增欄位 category_id 用的 跟MODEL 那邊的功能不一樣
      t.belongs_to :category
      t.timestamps
    end
  end
end
