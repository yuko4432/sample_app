class User < ApplicationRecord
  
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", class_name:  "Relationship", dependent: :destroy
  has_many :relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def feed
    Micropost.where("user_id = ?", id)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end


  validates :name, presence: true, length: { maximum: 50 }

end
