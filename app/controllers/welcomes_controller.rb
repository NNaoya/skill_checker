class WelcomesController < ApplicationController
  ## 初期表示処理
  def index
    ## ログインしているかを判定する。
    if !logged_in?
      redirect_to '/login' and return
    end

    if "admin".eql?(@current_user.roll)
      ## rollが管理者の場合は、管理者画面に遷移
      redirect_to '/admins/index'
    end

  end
end
