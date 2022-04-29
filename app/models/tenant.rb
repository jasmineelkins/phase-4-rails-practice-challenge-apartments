class Tenant < ApplicationRecord
  has_many :leases
  has_many :apartments, through: :leases
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  # validate :min_age

  # def min_age
  #   errors.add(:age, 'Tenant too young') if age < 17
  # end
end
