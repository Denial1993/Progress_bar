class ProductsController < ApplicationController
    before_action :redirect_to_root_if_not_log_in ,except: [:index,:show]
    before_action :create_ad,only: [:index,:products]
    before_action :get_current_page,only: [:index,:products]
    before_action :get_all_categories,only: [:index,:products,:show]
    before_action :get_products,only: [:index]
    before_action :create_pagination,only: [:index]
  
    LIMITED_PRODUCTS_NUMBER = 20
  
  def index    
  end
  
  def new
    @product = Product.new
  end
  
  def create
    #接續def [save_file(newFile)]
    #上一個運作動作是:view/new.html.erb 裡面的[<%= f.file_field :image %>]
    #但我個人認為這格參數還要透過下面的[product_permit] 去拿到。 
    image = params[:product][:image]
    #找到image圖檔來源以後,我們要把資料存起來,這時候就會用到下面的[def save_file(newFile)]
    if image
      image_url = save_file(image)
    end
    
    #{image_url: image_url} ; 如果兩個hash要做連結(這裡指的是{image_url: image_url}跟參數(product_permit))
    #要用merge,所以本來的products = Product.create(product_permit) 會變成下面的新寫法。  
    @product = Product.create(product_permit.merge({image_url: image_url}))
    redirect_to root_path
    flash[:notice] = "建立成功"
  end
  
  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def edit
    #@id = params[:id] ##old
    @product = Product.find_by_id(params[:id])
#    redirect_to root_path
#    return  這兩行註解後 我點擊 編輯 他才帶我去編輯頁面
  end
  
  def update
    product = Product.find(params[:id])
    
    image = params[:product][:image]
    #如果圖片存在的話,再存,不然他沒圖片的情況下也會存,所以我們才設置if end
    if image
      image_url = save_file(image)
      product.update(product_permit.merge({image_url: image_url}))
    else
      product.update(product_permit)
    end
    
    
    flash[:notice] = "更新成功"
    redirect_to root_path
  end
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to action: :index
  end
  
  private
  
  def redirect_to_root_if_not_log_in
    if !current_user
      flash[:notice] = "您尚未登入"
      redirect_to root_path
      return
    end
  end
  
  def product_permit
#    params.permit([:name,:description,:image_url,:price])    舊寫法   配合form_tag用的
    #如果要改用form_for 那麼 在這行就要加上require(product)
    params.require("product").permit([:name,:description,:price,:subcategory_id])    
  end
  
  #如果我們要save 暫存的圖檔,就要設計這個[save_file(newFile)]把它存下來。
  def save_file(newFile)
    #丟進來之後要給他一個路徑,那這個路徑可能本來是不存在的。
    #所以我們創了一個[dir_url] 然後 Rails.root 路徑底下的[public],第二個參數["uploads/products"] 可以自動產生這個資料夾。
    dir_url = Rails.root.join("public","uploads/products")
    #如果要建立資料夾,我們就要用RuBy預設的class[FileUtils],來幹這件事情
    #mkdir是建立資料夾, 而-p就是用來建立中間"原本沒有的路徑"。 
    ###所以這句的目的是: 如果他沒有這路徑,我們就他媽的把她建出來
    FileUtils.mkdir_p(dir_url) unless File.directory?(dir_url)

    file_url = dir_url + newFile.original_filename
    
    File.open(file_url, "w+b") do |file|
      #newFile是我們丟進來的檔案,,那我們把她讀出來
      #而上面的|file| 是我們新開的檔案,所以我們把它[(newFile.read)]寫進去
      file.write(newFile.read)
    end
    #上面都做完以後我們把這個資料丟回去存進資料庫裡
    #阿這段本來是return file_url,改成 =>
    #return file_url 舊寫法。
    return "/uploads/products/" + newFile.original_filename
    #上面這邊 最後面uploads/products 要加上"/", 之前join那邊是他會幫我們加上  ,但這邊return我們是手動自己加的所以要自己加上/
    #注意"/uploads/products/" 跟 newFile.original_filename 中間是+號   之前寫","  搞了半天才運作歐歐歐歐 
  end
   
  def  create_ad
    @ad = {
      title: "PSGB__",
      des: "Store for sale equipments what you need and what you want.",
      action_title: "熱門推薦",
    }
  end
  
  def get_current_page
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
  end
    
  def get_all_categories
    @categories = Category.all
  end
  
  def create_pagination
    @first_page = 1
    count = @products_3.count
    @last_page = (count/LIMITED_PRODUCTS_NUMBER)
    
    if count % LIMITED_PRODUCTS_NUMBER
      @last_page += 1
    end
    
    
=begin
    舊寫法##舊寫法##舊寫法#舊寫法##舊寫法##舊寫法#
    @products_3 = []
    (9..PRODUCTS_COUNT).each do |index|
      product = 
      {
        id: index,
        name: "Ducati Panigale V4",
        description: "#{index}",
        image_url: "https://images.pexels.com/photos/1309668/pexels-photo-1309668.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
      }
      @products_3 << product
    end
    @products_3 = @products_3[(@page - 1) * LIMITED_PRODUCTS_NUMBER , LIMITED_PRODUCTS_NUMBER] 
    舊寫法##舊寫法##舊寫法#舊寫法##舊寫法##舊寫法#
=end
  
    @products_3 = @products_3.offset((@page - 1) *LIMITED_PRODUCTS_NUMBER).limit(LIMITED_PRODUCTS_NUMBER)
  end
  
  def  get_products
    @products_3 = Product.all    
  end
end
