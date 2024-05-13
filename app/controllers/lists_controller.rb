class ListsController < ApplicationController
  def new
    @list = List.new
  end
  
  def create
    # データを受け取り新規登録するインスタンス作成
    @list = List.new(list_params)
    # データをデータベースに保存するsaveメソッド実行
    if @list.save
    # フラッシュメッセージを定義、詳細画面へリダイレクト
      flash[:notice] = "投稿に成功しました。"
      redirect_to list_path(@list.id)
    else
      # フラッシュメッセージを定義、new.html.erbを描画
      # flash.now[:notice] = "投稿に失敗しました。"
      
      flash.now[:alert] = "投稿に失敗しました。"
      # キーをalertに変更
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end
  
  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
