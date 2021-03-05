class ApplicationController < ActionController::Base
  #這裡是所有controller 的 母體,所以其他子類別發動前 這邊為優先,而因為current_user 我們期望在每個子類別都會運作,所以放在這邊。
  #這個before_action 是因為從def log_in 拉出來的 ,因為每個介面都要有登入狀態。
  before_action :current_user
  
  def current_user
    #這裡是為了 不要讓下面的 find_by_id 一直做動,當 網頁瀏覽過一次之後 就會catch住資料了 所以沒必要每次運行網頁都一直find_by_id。
    if @current_user
      return @current_user
    end
    
    current_user_id = session[:current_user_id]
      if current_user_id
        @current_user = User.find_by_id(current_user_id)
      end
  end
end
