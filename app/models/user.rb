class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_one_attached :avatar
  validates :avatar, presence: true
  validate :avatar_is_image

  def avatar_is_image
    errors.add(:avatar, "must be an image") if !avatar.image?
  end
end
