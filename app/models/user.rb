class User < ApplicationRecord

  #adds a 'virtual' attribute to the model, that does not get saved in the DB. We don't want to store the user's plaintext password in our DB, just the digested version.
  has_secure_password
  paginates_per 10
  
  has_many :reviews

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20}, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end


end
