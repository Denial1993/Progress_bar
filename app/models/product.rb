class Product < ApplicationRecord
  #之前犯ㄉ錯,注意:belongs_to 後面慣例是單數!  上次寫覆數難怪啥都找不到= =
  belongs_to :subcategory
end
