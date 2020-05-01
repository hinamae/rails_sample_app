class User < ApplicationRecord
before_save { email.downcase!}
validates :name, presence: true,length: { maximum: 50}
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :email, presence: true,length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
has_secure_password
validates :password, presence: true, length: {minimum: 6}

#仮想のtoken属性
attr_accessor :remember_token

#digestメソッドは各場面で使用できるため、user.rbにおいてクラスメソッドとする
#テスト用のデータ(ユーザ登録済みのユーザ情報)が登録されていなければならない
#password_digest属性をユーザのフィクス茶に追加する
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        #ユーザ用のbcryptパスワードの作成
        BCrypt::Password.create(string, cost: cost)
    end

    #ランダムなtokenを返す（token=PC側で管理するsession情報のパスワードのようなもの）
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #永続セッションのためにユーザをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest,nil)
    end
end
