class UserskillsController < ApplicationController
  ## 変数初期化
  @@category_id = ""

  ## 初期表示処理
  def new
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    @@category_id = params[:category_id]
    ## スキル情報取得
    @userskill = Userskill.find_by_sql(['SELECT * FROM skillChecker_development.userskills A,skillChecker_development.skills B where A.skill_id = B.id AND A.user_id = ? AND B.category_id = ?;', session[:user_id], params[:category_id]])
    if !@userskill.empty?
      ##　登録済みの場合

      ## 更新用画面に遷移
      redirect_to '/userskills/update'
    end
      ##　未登録の場合

      ## 登録用画面に遷移
      @userskill = Userskill.new
      @result = Skill.where(category_id: params[:category_id])
      @userskill_insert_update_flag = "0"
  end

  ## 更新用画面表示処理
  def update
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login'
    end

    @userskill = Userskill.new
    @result = Userskill.find_by_sql(['SELECT A.id,A.skill_id,A.level,A.comment,B.skill FROM skillChecker_development.userskills A,skillChecker_development.skills B where A.skill_id = B.id AND A.user_id = ? AND B.category_id = ?', session[:user_id],@@category_id])
    @userskill_insert_update_flag = "1"
  end

  ## 登録・更新処理
  def create
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    if params[:userskill_insert_update_flag].eql?("0")
      ##登録の場合
      for i in 0..5
        skillid = "skillid" + i.to_s
        skill = "skill" + i.to_s
        comment = "comment" + i.to_s
        @userskill = Userskill.new(user_id: session[:user_id],skill_id: params[:"#{skillid}"],level: params[:"#{skill}"],comment: params[:"#{comment}"] )
        @userskill.save!
      end

    else
      ##　更新の場合
      for i in 0..5
        userskillid = "userskillid" + i.to_s
        skillid = "skillid" + i.to_s
        skill = "skill" + i.to_s
        comment = "comment" + i.to_s
        @userskill = Userskill.find(params[:"#{userskillid}"])
        @userskill.level = params[:"#{skill}"]
        @userskill.comment = params[:"#{comment}"]
        @userskill.save!
      end
    end

    ## 現在のスキル合計値を登録
    sum = 0
    @result = Userskill.where(user_id: session[:user_id])
    @result.each do |result|
      sum = result.level.to_i + sum
    end
    @point = Point.new(user_id: session[:user_id],sum: sum)
    @point.save!
    redirect_to '/skill_registration_update/index', notice: 'スキル登録が完了しました。'

  end

  ##　ストロングパラメータ
  private
  def userskill_params
    params.require(:userskill).permit(:skill1, :comment1)
  end
end
