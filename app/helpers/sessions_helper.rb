module SessionsHelper

    #渡されたユーザでログインする
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id]=user.id
        cookies.permanent[:remember_token]=user.remember_token
    end

    #渡されたユーザがログイン済みユーザであればtrueを返す
    def current_user?(user)
        user == current_user
    end

    def current_user
        #ユーザIDにユーザIDのセッションを代入した場合に、ユーザIDのセッションが存在すれば真
        if (user_id = session[:user_id])
        #現在ログイン中のユーザがいる場合ユーザオブジェクトを返す（そうでない場合nilを返す）           
            @current_user ||=User.find_by(id: user_id)
        #cookies[:user_id]からユーザを取り出して、対応する永続セッションにログインする必要がある        
        elsif (user_id = cookies.signed[:user_id])
            user=User.find_by(id: user_id)
            if user && user.authenticated?(:remember,cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end

    end

    #ユーザがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end
    
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    #記憶したURLもしくはデフォルト値にリダイレクト
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    #アクセスしようとしてURLを覚えておく
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

end
