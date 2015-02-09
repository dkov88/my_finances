class Budget < ActiveRecord::Base
  validates :description, presence: true
  validates :amount, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }
  validates :money_kind, presence: true,
            format: { :with => /\A(income|expense)\z/}
end
