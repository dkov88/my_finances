class Wallet < ActiveRecord::Base
  belongs_to :user
  has_many :budgets
  
  validates :email, presence: true

end
