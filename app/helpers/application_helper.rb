module ApplicationHelper
  #就是因為這邊有這個 所以才能 在view 介面直接call   current_user.name 叫出名稱
  def current_user
    return @current_user
  end
end
