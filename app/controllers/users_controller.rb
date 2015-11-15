class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.page(params[:page]).per(5) #ページネーション
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!" # アラート
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] = "プロフィールを編集しました"
      redirect_to user_path
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def followings #課題
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page]).per(5) #ページネーション
  end

  def followers #課題
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page]).per(5) #ページネーション
  end

  def index
    @array = [:page]
    users = User.all
    users.each do |user|
      array.push({
          name: user.name,
          foo: user.hoge.first.foo
      })
    end
    @hoge = Kaminari.paginate_array(array).page(params[:page]).per(5)
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :area, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end