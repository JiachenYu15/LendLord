class Rating < ApplicationRecord
    belongs_to :rater, :foreign_key => :rater, :class_name => 'User'
    belongs_to :ratee, :foreign_key => :ratee, :class_name => 'User'
    belongs_to :my_transaction, :foreign_key => :transaction_id, :class_name => 'Transaction'

    validates :rater, presence: true
    validates :ratee, presence: true
    validates :transaction_id, presence: true
    validates :score, presence: true
    validates :score, :inclusion => 1..5
end
