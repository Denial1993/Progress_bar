class AddSubcategoryIdInProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products,:subcategory_id,:integer
    #在sQL 裡面 即便在add_column :products,:subcategory_id,:integer,index: true 他也不會幫你建立索引,(mysql.PostgreSQL會),所以我們才會有下面這行[ add_index :products,:subcategory_id]
    add_index :products,:subcategory_id
  end
end
