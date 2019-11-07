class Group < ApplicationRecord

  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages  
  validates :name, presence: true, uniqueness: true #nameカラムで重複した値が入らないようにする(一意性制約)
end
