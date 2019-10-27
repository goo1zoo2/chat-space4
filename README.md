# Chat-space DB設計
## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|

### Association
- has_many :tweets
- has_many :comments
- has_many :groups, through: :users_groups

## tweetsテーブル

|Column|Type|Options|
|------|----|-------|
|text|text||
|image|text||
|user_id|integer|null: false, foregin_key: true|
|group_id|integer|null: false, foregin_key: true|

### Association
- belongs_to :user
- belongs_to :group
- has_many :comments

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|text||
|image|text||
|user_id|integer|null: false, foregin_key: true|
|group_id|integer|null: false, foregin_key: true|
|tweet_id|integer|null: false, foregin_key: true|

### Association
- has_many :users
- has_many :groups
- belongs_to :tweet

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foregin_key: true|

### Association
- has_many :tweets
- has_many :comments
- has_many :users, through: :users_groups

## users_groupsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foregin_key: true|
|group_id|integer|null: false, foregin_key: true|

### Association
- belongs_to :user
- belongs_to :group