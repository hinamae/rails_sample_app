class User < ApplicationRecord
before_save { email.downcase!}
validates :name, presence: true,length: { maximum: 50}
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :email, presence: true,length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
has_secure_password
validates :password, presence: true, length: {minimum: 6}

#digestメソッドは各場面で使用できるため、user.rbにおいてクラスメソッドとする
#テスト用のデータ(ユーザ登録済みのユーザ情報)が登録されていなければならない
#password_digest属性をユーザのフィクス茶に追加する
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        #ユーザ用のbcryptパスワードの作成
        BCrypt::Password.create(string, cost: cost)
    end

end
