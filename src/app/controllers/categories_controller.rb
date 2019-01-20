class CategoriesController < ApplicationController
  ## 登録画面表示処理
  def new
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    ## 表示用のインスタンス作成
    @category = Category.new
    @skill = Skill.new

  end

  ## 更新画面表示処理
  def update
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    ## 表示用の情報取得
    @category_id = params[:category_id]
    @category = Category.find(@category_id)
    @skill = Skill.where(category_id: @category_id)

  end

  ## カテゴリー情報更新処理
  def create
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    ## categoriesテーブルのタイトル画像、アイコン画像の更新
    @category_id = params[:categoryid]
    @category = Category.find(@category_id)
    @category.title_image = params[:category][:title_image]
    @category.icon_image = params[:category][:icon_image]

    if @category.save
      ## カテゴリーの更新に成功した場合

      ##　カテゴリーに紐づくスキルの更新
      for i in 0..5
        skillid = "skillid" + i.to_s
        skill = "skill" + i.to_s
        @skill = Skill.find(params[:"#{skillid}"])
        @skill.skill = params[:"#{skill}"]
        @skill.save!
      end

      ##　管理画面に遷移
      redirect_to '/admins/index'
    else
      ##　カテゴリーの更新に失敗した場合

      flash.now[:alert] = "カテゴリーの登録に失敗しました"
      render :update
    end

  end
end
