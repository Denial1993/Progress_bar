Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  
  resources :products
  
  resources :categories , param: :category_id do
    #collection 跟 member 差異在於 m要參數,c 不用。
    collection do
#      get :products
    end
    
    #所以member就是 show 的概念 後面再加上你要新增的URL
    member do 
      get :products
      
      resources :subcategories ,param: :subcategory_id,only: [:index] do 
        member do 
           get :products
        end
      end
      
    end
  end
  
  #因為用不到create edit delete等功能,所以用舊方法製造路徑。
  get "admin/log_in" , to: "admin#log_in"
  #get "admin/log_in" /// "admin/log_out"  只會顯示頁面,他並不會有其他多餘的動作,所以我們還要一個post。 那至於登出就登出了,所以不需要post
  post "admin/create_session" , to: "admin#create_session"
  get "admin/log_out" , to: "admin#log_out"
end
