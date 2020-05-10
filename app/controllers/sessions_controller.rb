class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    #入力されたメールアドレスを持つユーザがデータベースに存在し、かつ入力されたパスワードがそのユーザのパスワードである場合
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        #ユーザログイン後にユーザ情報のページにリダイレクトする
        log_in user
        #[remember me]のチェックボックスの結果を送信する
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)

        #フレンドリーフォーワーディングを備えた
        redirect_back_or user
      else
        message = "Account not activated "
        message +="Check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
      
    else
      #エラーメッセージを作成する 
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    #ログイン中の場合のみログアウトする
    log_out if logged_in?
    redirect_to root_url
  end
end
