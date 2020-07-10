# README

# アプリケーション概要
メルカリのコピーサイト。
5人のチームでのアジャイル開発。

# 機能一覧
●ユーザー登録、ログイン機能
●商品出品機能
●商品購入機能

# 使用技術
## バックエンド
Ruby
## フロントエンド
jquery
## フレームワーク
Ruby on Rails
## データベース
MySQL
## インフラ
AWS EC2 S3
## デプロイ
Capistranoによる自動デプロイ
## ER Diagram


## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|nickname|string|null: false, unique: true, index|
|first_name|string|null: false|
|first_name_furigana|string|null: false|
|last_name|string|null: false|
|last_name_furigana|string|null: false|
|profile_photo|string|null: false|
|birthday|date|null: false|
|tel_number|string|null: false|
|email|string|null: false|
|password|string|null: false|
|introduction|text|
### Association
- has_one :address, dependent: :destroy
- has_many :products
- has_many :comments, dependent: :destroy
- has_many :cards, dependent: :destroy



## Addressテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|postal_code|integer|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|other|string|null: false|
|building_name|string|null: false|
|user_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user



## Cardテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|integer|null: false|
|customer_id|integer|null: false|
|user_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user




## Productテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|
|price|integer|null: false|
|status|string|null: false|
|brand|string|null: false|
|explanation|text|null: false|
|delivery_charge_id|integer|null: false|
|send_day_id|integer|null: false|
|user_id|integer|foreign_key: true, null: false|
|category_id|integer|foreign_key: true, null: false|


### Association
- belongs_to :user
- belongs_to :category
- has_many :comments, dependent: :destroy
- has_many :product_photos, dependent: :destroy



## Categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :products




## Product_photoテーブル
|Column|Type|Options|
|------|----|-------|
|photo|string|null: false|
|product_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :product



## Likeテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true, null: false|
|product_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user
- belongs_to :product


## Commentテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|text|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|product_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user
- belongs_to :product
＃readme＃readme