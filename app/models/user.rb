class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true,length: { maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true

# #仮想のtoken属性
# attr_accessor :remember_token

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

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest,nil)
    end

    #アカウントを有効にする
    def activate
        update_columns(activated: true , activated_at: Time.zone.now)
    end

    #有効化用のメールを送信する
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end


    private
        #メールアドレスをすべて小文字にする
        def downcase_email
            self.email.downcase!
        end


    # 有効化トークンとダイジェストを作成および代入する
        def create_activation_digest
            self.activation_token  = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
  end
