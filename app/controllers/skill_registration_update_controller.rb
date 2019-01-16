class SkillRegistrationUpdateController < ApplicationController
  ## 変数の初期化
  @categoryNum = ""

  ## 初期表示処理
  def index
    ## ログインしているかを判定
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

    if Project.where(user_id: session[:user_id]).count > 0
      ##　プロジェクト情報が存在する場合

      ##　プロジェクト情報を取得
      @project = Project.find_by(user_id: session[:user_id])
      @project_insert_update_flag = "1"
    else
      ## プロジェクト情報が存在しない場合

      ## 新規にインスタンス作成
      @project = Project.new
      @project_insert_update_flag = "0"
    end

    if Qualification.where(user_id: session[:user_id]).count > 0
      ##　資格情報が存在する場合

      ##　資格情報を取得
      @qualification = Qualification.where(user_id: session[:user_id])
      @qualification_insert_update_flag = "1"
    else
      ##　資格情報が存在しない場合

      ## 新規にインスタンス作成
      @qualification = Qualification.new
      @qualification_insert_update_flag = "0"
    end

    if Selfintroduction.where(user_id: session[:user_id]).count > 0
      ##　その他情報が存在する場合

      ##　その他情報を取得
      @selfintroduction = Selfintroduction.find_by(user_id: session[:user_id])
      @selfintroduction_insert_update_flag = "1"
    else
      ##　その他情報が存在しない場合

      ## 新規にインスタンス作成
      @selfintroduction = Selfintroduction.new
      @selfintroduction_insert_update_flag = "0"
    end
  end

  ##　経歴情報更新処理
  def create
    ## ログインしているかを判定する。
    if !logged_in?
      redirect_to '/login' and return
    end

    ## 新規登録 or 更新を判定する。
    if params[:project_insert_update_flag].eql?("0")
      ##新規登録の場合
      @project = Project.new(project_params)
      @project.save!

    else
      ##　更新の場合
      @project = Project.find(params[:project_id])
      @project.project_period = params[:project][:project_period]
      @project.project_name = params[:project][:project_name]
      @project.project_overview = params[:project][:project_overview]
      @project.phase = params[:project][:phase]
      @project.business = params[:project][:business]
      @project.technical_element = params[:project][:technical_element]
      @project.save!

    end

    ## 新規登録 or 更新を判定する。
    @count = params[:qualification_count]
    for i in 1..@count.to_i
      flag = "qualification_insert_update_flag" + i.to_s
        if params[:"#{flag}"].eql?("0")
          ##新規登録の場合
          qualification = "qualification" + i.to_s
          @qualification = Qualification.new(user_id: session[:user_id],qualification: params[:"#{qualification}"])
          @qualification.save!

        else
          ##　更新の場合
          qualification_id = "qualification_id" + i.to_s
          qualification = "qualification" + i.to_s
          @qualification = Qualification.find(params[:"#{qualification_id}"])
          @qualification.qualification = params[:"#{qualification}"]
          @qualification.save!

        end
    end

    ## 新規登録 or 更新を判定する。
    if params[:selfintroduction_insert_update_flag].eql?("0")
      ##新規登録の場合
      @selfintroduction = Selfintroduction.new(selfintroduction_params)
      @selfintroduction.save!

    else
      ##　更新の場合
      @selfintroduction = Selfintroduction.find(params[:selfintroduction_id])
      @selfintroduction.self_introduction = params[:selfintroduction][:self_introduction]
      @selfintroduction.save!

    end
    redirect_to '/skill_registration_update/index', notice: 'スキル登録が完了しました。'

  end

  private
  def project_params
      params.require(:project).permit(:project_period, :project_name, :project_overview, :phase, :business, :technical_element, :user_id)
  end

  def qualification_params
      params.require(:qualification).permit(:qualification, :user_id)
  end

  def selfintroduction_params
      params.require(:selfintroduction).permit(:self_introduction, :user_id)
  end

end
