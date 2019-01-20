class AdminsController < ApplicationController
  def index
    ## ログインしているかを判定する。
    if !logged_in?
      redirect_to '/login' and return
    end

    ## カテゴリー数取得
    @categoryNum = Category.count

    ## カテゴリー数分ループ
    @category = []
    for i in 1..@categoryNum
      ## Skillテーブルからスキル項目取得
      result = Category.find_by_sql(['SELECT A.id,A.name,A.title_image,A.icon_image,B.skill FROM skillChecker_development.categories A,skillChecker_development.skills B where A.id = B.category_id AND B.category_id = ?;',i])

      ## 配列のスキル関連項目の結果を格納
      @category.push(result)
    end

    ## ユーザー情報取得
    @user = User.find(session[:user_id])

  end

  ## パスワード変更処理
  def update
    ## ログインしているかを判定する。
    if !logged_in?
      redirect_to '/login' and return
    end

    ##　パスワード変更対象のユーザー情報取得
    @user = User.find(session[:user_id])

    ##  画面で入力されたパスワード情報を設定
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      ##　パスワード変更に成功した場合

      ##　管理画面に遷移
      redirect_to '/admins/index', notice: 'パスワード変更が完了しました。'
    else
      ##　パスワード変更に失敗した場合

      ##　管理画面に遷移
      flash.now[:alert] = 'パスワード変更に失敗しました。'
      render :index
    end

  end
end
