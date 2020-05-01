# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。   
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
[Michael Hartl](http://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は [LICENSE.md](LICENSE.md) をご覧ください。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install --without production
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。


## sqlite3 error時


```
gem uninstall sqlite3
gem install sqlite3 -v "~> 1.3.6" --platform ruby 
```


## bcrypt error時
```
gem uninstall bcrypt
gem install bcrypt -v "3.1.12"  --platform ruby

```

## 流れ

- testを記述
- routerに記述
- コントローラーにモデルのアクションを作成

## test

```
rails test
rails test :integration
rails test:models

```

## console

```
rails console
#DBをロールバックして終了する
rails console --sandbox
```

## DBの状態を確認

```
rails db:migrate:status
```


## DBの状態をreset

```
rails db:migrate:reset
```

db:drop:_unsafe
db:migrate


## error確認

```
# user作成
user= User.new(name:"yamada",email:"yamada@example.com",password:"1234")
# 正当性の確認
user.valid?
# エラーメッセージの詳細確認
user.errors.full_messages

## DBにユーザ登録、変更

```cmd
#ユーザの属性変更(1こ)
 user.update_attribute(:email, "example@railstutorial.org")  
```

## byebugのエラー対応

gemfile、
 gem 'byebug', '~> 9.0', '>= 9.0.6', platform: [:mri, :mingw, :x64_mingw]
 に書き換えて、
bundle updateした。

debuggerメソッド使うと、rails serverしたときに、byebugプロンプトが表示される。
デバック時に使用する。

## Gravatars

https://en.gravatar.com/emails

名前と画像を紐づけしてくれる外部サイト


## ruby文法

- シンボル
params[:user]

## 使用されているオブジェクト

- model
単数形
user
session


- contoroller
複数形
users
static_pages
sessions

- action
    - コントローラーに記述されるメソッド
new＝ログインページを表示
create＝ログインを完了する
destroy=ログアウトを完了する

- partial
renderメソッドを使用し、繰り返しを簡略化する。
<%= render %>の形で呼び出すことができる

- 変数
    - ローカル変数
        普通に定義されるやつ
    - インスタンス変数
        @~~で定義されるやつ

## ルーター確認

```
rails routes
```

アプリケーションで使用できる全アクションもこの出力から確認することができる