class UsersearchesController < ApplicationController
  ## 初期表示処理
  def index
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    ## 検索条件項目のインスタンス作成
    @category = Category.new
    @skill = Skill.new
    ## 検索ボタンが押下された場合
    if params[:search_flag].eql?("1")
      ## 検索結果をインスタンス変数に設定
      @user = Userskill.find_by_sql(['SELECT D.id,D.name,D.email FROM skillChecker_development.userskills A,skillChecker_development.skills B ,skillChecker_development.categories C,skillChecker_development.users D where A.skill_id = B.id AND B.category_id = ? AND B.category_id = C.id AND B.id = ? AND A.user_id = D.id AND A.level = ?;',params[:category][:id],params[:skill][:id],params[:level]])
    else

    end
  end

  ## 検索条件の変更処理(Ajax処理)
  def search
    @criteria = Skill.where(category_id: params[:category])
    render json: @criteria
  end

end
