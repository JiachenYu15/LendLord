class Transaction < ApplicationRecord
  has_many :ratings

  validates :item_id,
            presence: true
  validates :user_id,
            presence: true
  validates :deposit,
            presence: true
  validates :status,
            presence: true
  validates :payment_id,
            presence: true
  validate :due_date_cannot_be_earlier_than_start_date


  def due_date_cannot_be_earlier_than_start_date
    errors.add(:due_date, "Due date can't be earlier than start date.") \
    unless due_date > start_date
  end

end
