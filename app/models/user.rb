class User < ActiveRecord::Base
  validates :name,  presence: true,
                    uniqueness: true
  validates :email, presence: true
  validates :password, presence: true,
                       length: { minimum: 5, maximum: 40 },
                       confirmation: true
  validates :password_confirmation, presence: true
end
