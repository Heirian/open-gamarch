class User < ApplicationRecord
  attr_accessor :remember_token
  before_save   :downcase_email
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :articles, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :communities
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :bio, length: { maximum: 140 }
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  enum gender: { boy: 0, girl: 1 }
  validates :gender, presence: true
  validates :birthday, presence: true

  mount_uploader :avatar, AvatarUploader
  validate  :avatar_size

  mount_uploader :image, ImageUploader
  validate :image_size

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Article.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Validates the size of an uploaded avatar.
  def avatar_size
    return unless avatar.size > 100.kilobytes
    errors.add(I18n.t(:image), "#{I18n.t(:size_avatar)}
     #{I18n.t(:avatar_size_after_resize)} 100KB")
  end

  # Validates the size of an uploaded image.
  def image_size
    return unless image.size > 100.kilobytes
    errors.add(I18n.t(:image), "#{I18n.t(:size_cover)}
      #{I18n.t(:cover_size_after_resize)} 100KB")
  end
end
