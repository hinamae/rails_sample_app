module SessionsHelper

    #渡されたユーザでログインする
    def log_in(user)
        session[:user_id] = user.id
    end
    #現在ログイン中のユーザがいる場合ユーザオブジェクトを返す（そうでない場合nilを返す）
    def current_user
        # if session[:user_id]
        #     User.find_by(id: session[:user_id])
        # else
        #     @current_user
        # end
        #この上5行の短縮系が、下一行

        @current_user ||= User.find_by(id: session[:user_id])
    end

    #ユーザがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
