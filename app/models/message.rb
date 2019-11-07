class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :content, unless: :image?
  mount_uploader :image, ImageUploader
end