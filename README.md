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

## error確認

```
# user作成
user= User.new(name:"yamada",email:"yamada@example.com",password:"1234")
# 正当性の確認
user.valid?
# エラーメッセージの詳細確認
user.errors.full_messages
```