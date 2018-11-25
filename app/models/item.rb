class Item < ApplicationRecord

  belongs_to :user
  :name
  :description
  :deposit
  :is_available
  :is_deleted

  validates_presence_of :name
  validates_numericality_of :deposit, :message=>"must be a number"
end