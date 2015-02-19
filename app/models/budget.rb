class Budget < ActiveRecord::Base
  belongs_to :wallet
  #belongs_to :user

  validates :description, presence: true
  validates :amount, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }
  validates :money_kind, presence: true,
            format: { :with => /\A(income|expense)\z/}
  validates_presence_of :wallet_id

end
