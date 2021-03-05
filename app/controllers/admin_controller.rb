class AdminController < ApplicationController
  before_action :redirect_to_root_if_log_in ,except: [:log_out]
  before_action :redirect_to_root_if_not_log_in ,only: [:log_out]
  def log_in
  end
  
  def log_out
    session[:current_user_id] = nil
    flash[:notice] = "登出"
    redirect_to root_path
    return
  end
  
  def create_session
    user = User.find_by(email: params[:email] , password: params[:password])
    
    #把事情單純點,所以我們改找尋user.id然後套在下面這的判別式
    if user
      session[:current_user_id] = user.id
      flash[:notice] = "登入成功!"
      #如果到redirect_to root_path就要結束,這個並不會讓你真的結束,所以要擺上return
      redirect_to root_path
      return
    end
    
    flash[:notice] = "登入失敗!"
    redirect_to action: :log_in
  end
  
  def redirect_to_root_if_log_in
    if current_user
      flash[:notice] = "已經登入了"
      redirect_to root_path
      return
    end
  end
  
  def redirect_to_root_if_not_log_in
    if !current_user
      flash[:notice] = "您尚未登入"
      redirect_to root_path
      return
    end
  end
end
