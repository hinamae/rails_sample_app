class UsersController < ApplicationController
  #何らかの処理（アクション）が実行される直前に特定のメソッドを実行する
  #onlyオプションによって:edit と:updateアクションだけにこのbeforeフィルタが適用されるように制限をかける
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  #destroyアクションへのアクセスを制御する
  before_action :admin_user , only: :destroy
  
  def index
    #ページネートする(デフォルトは30。30ごとにページを分けて全ユーザーを表示する)
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    # user_paramsメソッドはWeb経由で外部ユーザにさらされる必要はないため安全
    # Web経由で外部ユーザにさらされていると、curlなどでWebリクエストに危険なコードを紛れ込ませることをされてしまう
    @user = User.new(user_params)
    if @user.save
      #ユーザモデルオブジェクトからメールを送信する
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
        # #ユーザ登録中にログインを済ませておく
        # log_in @user
        # #新規アカウント作成後に"Welcome to Twitter modoki!!"を表示
        # flash[:success]="Welcome to Twitter modoki!!"
        # redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #更新に成功した場合
      flash[:success] = " Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

    #user_paramsメソッドはプライベートメソッドのためインデントを一段深くしている
    #paramsハッシュに対してrequireとpermitをよびだすと、編集してもよい安全な属性だけを更新できるようになる
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #適切な
    #ログイン済みユーザかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end

    #正しいユーザかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirected_to(root_url) unless current_user?(@user)
    end

    #ユーザのデリートのアクション
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

    #adminユーザかどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end