class Budget < ActiveRecord::Base
  belongs_to :wallet

  validates :description, presence: true
  validates :amount, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }
  validates :money_kind, presence: true,
            format: { :with => /\A(income|expense)\z/}
  validates_presence_of :wallet_id


  scope :description, -> (description) { where("description like ?", "%#{description}%")}
  scope :money_kind, -> (money_kind) { where money_kind: money_kind }
  scope :start_date, -> (start_date) { where("date >= ?", "#{start_date}")}
  scope :end_date, -> (end_date) { where("date <= ?", "#{end_date}")}
  
  


end
