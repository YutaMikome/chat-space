
# DB設計 #


## messages table ##

| Column     | Type        | Options         |
|:-----------|:------------|:----------------|
| body       | text        |null: false      |
| image      | string      |                 |
| group_id   | integer     |foreign_key: true|
| user_id    | integer     |foreign_key: true|
| timestamps | integer     |null: false      |

### Association ###

- belongs_to :user

- belongs_to :group


## users table ##

| Column     | Type        | Options                              |
|:-----------|:------------|:-------------------------------------|
| name       | string      |index: true, null: false, unique: true|

### Association ###

- has_many :massages

- has_many :group_users

- has_many :groups, through: group_users


## groups table ##

| Column     | Type        | Options                 |
|:-----------|:------------|:------------------------|
| name       | string      |null: false, unique: ture|

### Association ###

- has_many :users

- has_many :group_users

- has_many :messages

## group_users table ##

| Column     | Type        | Options         |
|:-----------|:------------|:----------------|
| group_id   | integer     |foreign_key: true|
| user_id    | integer     |foreign_key: true|

### Association ###

- belongs_to :user

- belongs_to :group
