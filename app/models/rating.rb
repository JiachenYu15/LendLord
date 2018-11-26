class Rating < ApplicationRecord
    belongs_to :rater, :foreign_key => :rater, :class_name => 'User'
    belongs_to :ratee, :foreign_key => :ratee, :class_name => 'User'
    belongs_to :my_transaction, :foreign_key => :transaction_id, :class_name => 'Transaction'

    validate :rater, presence: true
    validate :ratee, presence: true
    validate :transaction_id, presence: true
end
