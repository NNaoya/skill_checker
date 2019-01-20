class UsersController < ApplicationController
  ## 初期表示処理
  def new
    @user = User.new
  end

  ## ユーザー登録処理
  def create
    ## ユーザー登録画面で入力された情報を元に、インスタンス作成
    @user = User.new(user_params)
    ## 登録ユーザーのrollは一般ユーザーに設定
    @user.roll = 'user'
    if @user.save
      ## 登録に成功した場合、ログイン画面に遷移
      redirect_to '/login', notice: 'ユーザー登録が完了しました。'
    else
      ## 登録に失敗した場合、ユーザー登録画面に遷移
      flash.now[:alert] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end

  ##  ストロングパラメータ
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
