class Person < ApplicationRecord

    belongs_to :user
    has_many :items, dependent: :destroy

    validates :username,:presence => true
    validates :firstname,:presence => true
    validates :lastname, :presence => true
    validates :telephone,:presence => true
    validates :country, :presence => true
    validates :city, :presence => true
    validates :address,:presence => true

    def location
        [street, city, country].compact.join(', ')
    end

end
