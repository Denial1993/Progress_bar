class CategoriesController < ProductsController
  before_action :get_category , only: [:products]
  before_action :get_products,only: [:products]
  before_action :create_pagination,only: [:products]
  
  public
  
  def products
  end
  
  private
  
  def  get_products
    @products_3 = @category.products   
  end
  
  def get_category
    #[:categor_id] 這裏面裝甚麼，取決於你routes 裡面的路徑是怎麼寫的,可以看36章節的04:36秒。
    #params 後面的框框要靠近params 不然會錯誤。
    @category = Category.find_by_id(params[:category_id])
  end
end
