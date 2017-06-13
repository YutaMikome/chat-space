class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :group

  validates :body, presence: {if: 'image.blank?'}
  validates :image, presence: {if: 'body.blank?'}
  validates :group_id, presence: true
  validates :user_id, presence: true
end
