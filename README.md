## DB設計

## usersテーブル
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
- has_one :address
- has_many :products
- has_many :comments
- has_many :cards



## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|other|string|null: false|
|building_name|string|null: false|
|user_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user



## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|integer|null: false|
|customer_id|integer|null: false|
|user_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user




## productsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|
|price|integer|null: false|
|status|string|null: false|
|brand|string|null: false|
|explanation|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|category_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user
- belongs_to :category
- has_many :comments
- has_many :product_photos



## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :products




## product_photosテーブル
|Column|Type|Options|
|------|----|-------|
|photo|string|null: false|
|product_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :product




## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|text|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|product_id|integer|foreign_key: true, null: false|
### Association
- belongs_to :user
- belongs_to :product
