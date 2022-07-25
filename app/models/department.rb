class Department < ApplicationRecord
  has_many :employees

  validates_presence_of :name
  validates_presence_of :floor
end