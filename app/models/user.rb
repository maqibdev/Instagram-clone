# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :followeds, through: :followings
  has_many :followed_requests_sent, -> { where(status: false) }, class_name: 'Following', dependent: :destroy
  has_many :followed_requests_received, lambda {
                                          where(status: false)
                                        }, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :like, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: { open: 0, close: 1 }
  validates :name, presence: true, length: { minimum: 2, maximum: 50, too_long: ' Max Limit is 50' }
  validates :photo, presence: true
  include PgSearch
  pg_search_scope :search, against: %i[name email]
  def self.text_search(query)
    search(query) if query.present?
  end
end
