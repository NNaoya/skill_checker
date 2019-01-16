class SkillReferenceController < ApplicationController
  ## 初期表示処理
  def index
    ## ログインしているかを判定
    if !logged_in?
      redirect_to '/login' and return
    end

    ## 変数初期化
    @user = params[:user_id]
    @categoryNum = Category.count
    allCategoryData = []
    category = []
    history = []
    skillSum = []

    ## 登録されているカテゴリー数分ループ
    for i in 1..@categoryNum
      ## 変数初期化
      skillGenre = []
      eachCategoryData = []
      levelSum = 0
      text_comment = ""
      count = 0

      ## 分野ごとの分析情報処理、全分野の分析情報処理の共通　ここから
      @skill = Skill.where(category_id: i)
      @skill.each do |result|
        skillGenre.push(result.skill)
      end

      @userskill = Userskill.find_by_sql(['SELECT A.level,A.comment,B.skill, C.name FROM skillChecker_development.userskills A,skillChecker_development.skills B ,skillChecker_development.categories C where A.skill_id = B.id AND A.user_id = ? AND B.category_id = ? AND B.category_id = C.id;', @user,i])
      @userskill.each do |result|
        eachCategoryData.push(result.level.to_i)
        text_comment =  text_comment + result.skill + ":" + result.comment + "\n"
        levelSum = levelSum + result.level.to_i
      end

      if eachCategoryData.empty?
        @skill.each do |result|
          eachCategoryData.push(0)
        end
      end
      ## 分野ごとの分析情報処理、全分野の分析情報処理の共通　ここまで

      ## 分野ごとの分析情報処理　レーダーチャート、コメント作成　ここから
      @comment_text = text_comment
      @category = Category.find(i)

      @graph = LazyHighCharts::HighChart.new('graph') do |f|
        f.chart(polar: true,type:'area',borderColor: '#07A8C1')
        f.pane(size:'90%')
        f.title(text: @category.name)
        f.xAxis(categories: skillGenre,tickmarkPlacement:'on')#categories:各項目の名前,tickmarkPlacement:'on'だとメモリ表示がカテゴリーの表示に沿う
        f.yAxis(gridLineInterpolation: 'polygon',lineWidth:0,min:0,max:3) #各項目の最大値やら
        f.series(name:'スキルレベル',data: eachCategoryData,pointPlacement:'on',color: '#07A8C1')#各データ
        f.legend(align: 'right',
        verticalAlign: 'top',
        y: 100,
        layout: 'vertical')
      end

      graph = "@graph" + i.to_s
      comment = "@comment" + i.to_s
      instance_variable_set("#{graph}", @graph)
      instance_variable_set("#{comment}", @comment_text)
      ## 分野ごとの分析情報処理　レーダーチャート、コメント作成　ここまで

      ## 全分野の分析情報処理の共通　ここから
      count = Skill.where(category_id: i).count
      average = levelSum.to_f/count
      average = average.round(2)
      allCategoryData.push(average)
      category.push(@category.name)
      ## 全分野の分析情報処理の共通　ここまで

    end

    ## 全分野の分析情報 棒グラフ作成　ここから
    @graph_data = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '全分野の分析結果')
      f.xAxis(tickInterval: 1)
      f.options[:xAxis] = [{ categories: category,labels: { rotation: 60}}]
      f.options[:yAxis] = [{ title: { text: 'スキルレベルの平均値' }}, { title: { text: ''},opposite: true}]
      f.series(name: '全分野の分析結果',data: allCategoryData,type: 'column', pointWidth: 20,color: '#07A8C1')
    end
    ## 全分野の分析情報 棒グラフ作成　ここまで

    ## 時期ごとの分析情報 棒グラフ作成　ここから
    @point = Point.where(user_id: @user)
    @point.each do |point|
      history.push(point.updated_at.strftime('%Y年%m月%d日 %H:%M:%S'))
      skillSum.push(point.sum.to_i)
    end

    @graph_data1 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '時期ごとの分析結果')
        f.xAxis(tickInterval: 1)
        f.options[:xAxis] = [{ categories: history,labels: { rotation: 80}}]
        f.options[:yAxis] = [{ title: { text: 'スキルレベルの合計値' }}, { title: { text: ''}, opposite: true}]
        f.series(name: '時期ごとの分析結果', data: skillSum, type: 'line',color: '#07A8C1')
    end
    ## 時期ごとの分析情報 棒グラフ作成　ここまで

    ## 経歴情報 棒グラフ作成　ここから
    if Project.where(user_id: @user).count > 0
      @project = Project.find_by(user_id: @user)
    else
      @project = Project.new
    end

    if Qualification.where(user_id: @user).count > 0
      @qualification = Qualification.where(user_id: @user)
    else
      @qualification = Qualification.new
    end

    if Selfintroduction.where(user_id: @user).count > 0
      @selfintroduction = Selfintroduction.find_by(user_id: @user)
    else
      @selfintroduction = Selfintroduction.new
    end
    ## 経歴情報 棒グラフ作成　ここまで

  end
end
