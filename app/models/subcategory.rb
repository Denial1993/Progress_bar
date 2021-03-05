class Subcategory < ApplicationRecord
  #這串才是真正"啟動" Subcategory 表格 與 Category表格 連結.
  #不懂的話可以看[建立分類關聯，blongs_to 的使用] 17:28 處
  belongs_to :category
  has_many :products
  
  def name_with_category
    #category.try(不一定有name 所以加上try) + 空格 + 自己的名子(Subcategory)
    category.try(:name) + " / " + name
  end
end
