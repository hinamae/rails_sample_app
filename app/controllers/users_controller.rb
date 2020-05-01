class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # user_paramsメソッドはWeb経由で外部ユーザにさらされる必要はないため安全
    # Web経由で外部ユーザにさらされていると、curlなどでWebリクエストに危険なコードを紛れ込ませることをされてしまう
    @user = User.new(user_params)
    if @user.save
        #ユーザ登録中にログインを済ませておく
        log_in @user
        #新規アカウント作成後に"Welcome to Twitter modoki!!"を表示
        flash[:success]="Welcome to Twitter modoki!!"
        redirect_to @user
    else
      render 'new'
    end
  end

    #user_paramsメソッドはプライベートメソッドのためインデントを一段深くしている
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end