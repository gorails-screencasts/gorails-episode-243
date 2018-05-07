class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_attached_file :avatar,
    styles: { medium: "300x300>", thumb: "100x100>" },
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV["S3_KEY"],
      secret_access_key: ENV["S3_SECRET"],
      bucket: 'gorails',
    },
    s3_region: 'nyc3',
    s3_protocol: :https,
    s3_options: { endpoint: 'https://nyc3.digitaloceanspaces.com' },
    s3_host_name: 'nyc3.digitaloceanspaces.com'

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\z/ }
  validates :avatar, attachment_presence: true
end
