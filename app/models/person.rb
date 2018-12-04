class Person < ApplicationRecord

    belongs_to :user
    has_many :items, dependent: :destroy

    validates :username,:presence => true
    validates :firstname,:presence => true
    validates :lastname, :presence => true
    validates :telephone,:presence => true
    validates :country, :presence => true
    validates :state, :presence => true
    validates :city, :presence => true
    validates :address,:presence => true
    validates :addressno,:presence => true, numericality: { only_integer: true }

    geocoded_by :location
    after_validation :geocode

    reverse_geocoded_by :lat, :lon
    after_validation :reverse_geocode

    def location
        [addressno, address, city, state, country].compact.join(', ')
    end

end
