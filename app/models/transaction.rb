class Transaction < ApplicationRecord

  validates :item_id,
            presence: true
  validates :borrow_from_user_id,
            presence: true
  validates :lend_to_user_id,
            presence: true
  validates :deposit,
            presence: true
  validates :status,
            presence: true
  validate :due_date_cannot_be_earlier_than_start_date


  def due_date_cannot_be_earlier_than_start_date
    errors.add(:due_date, "Due date can't be earlier than start date.") \
    unless due_date > start_date
  end

end
