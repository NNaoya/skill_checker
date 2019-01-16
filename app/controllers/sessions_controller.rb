class SessionsController < ApplicationController
  ## 初期表示処理
  def new
  end

  ## ログイン処理
  def create
    ## 入力されたEmailでusersテーブルを検索する。
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      ## usersテーブルにレコードが存在し、パスワード認証に成功した場合

      ## セッションにログインユーザーIDを設定する処理呼び出し
      log_in user
      if user.roll.eql?("admin")
        ## rollが管理者の場合は、管理者画面に遷移
        redirect_to '/admins/index'
      else
        ## rollが一般ユーザーの場合は、ようこそ画面に遷移
        redirect_to '/welcomes/index'
      end

    else
      ## usersテーブルにレコードが存在しない、もしくはパスワード認証に失敗した場合

      ## ログイン画面に遷移
      flash.now[:alert] = 'Emailとパスワードを正しく入力してください。'
      render :new
    end
  end

  ## ログアウト処理
  def destroy
    log_out
    redirect_to root_url
  end

  ## セッションにログインユーザーIDを設定する処理
  private
  def log_in(user)
    session[:user_id] = user.id
  end

  ## セッションの廃棄とインスタンス変数の初期化
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
