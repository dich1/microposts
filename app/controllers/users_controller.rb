class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def show
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
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
      redirect_to user_path , notice: 'メッセージを編集しました' # リンク飛ばす部分
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
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