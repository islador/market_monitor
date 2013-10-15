# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_many :apis
  has_many :market_orders
  has_many :cache_times
  has_many :market_item_summaries
  has_many :corporations
  has_many :characters

  before_save { |user| user.email = email.downcase}
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: {minimum: 10}
  validates :password_confirmation, presence: true

  def list_mis
    MarketItemSummary.where("user_id = ?", id)
  end

  private

  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
