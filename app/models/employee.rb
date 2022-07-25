class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  validates_presence_of :name
  validates_presence_of :level

  def employee_tickets
    tickets.order(age: :desc).limit(tickets.count - 1).offset(1)
  end 

  def oldest_ticket
    tickets.order(age: :desc).first
  end 

  def self.best_friends(id, ticket_ids)
    joins(:tickets).where(:tickets => {:id => ticket_ids}).where.not(id: id)
  end 
end