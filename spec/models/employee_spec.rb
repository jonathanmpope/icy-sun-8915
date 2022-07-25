require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets}
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :level }
  end

  describe 'instance methods' do
    describe '#employee_tickets' do
      it 'finds employee tickets other than the oldest' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        susan = shoes.employees.create!(name:"Susan", level:5)
        ticket1 =susan.tickets.create!(subject:"Discounts", age:3)
        ticket2 =susan.tickets.create!(subject:"Remove signs", age:1)
        ticket3 =susan.tickets.create!(subject:"Update prices", age:2)
        ticket4 =susan.tickets.create!(subject:"Clean shelving", age:5)
        ticket5 = susan.tickets.create!(subject:"Change layout", age:4)

        expect(susan.employee_tickets.count).to eq(4)
        expect(susan.employee_tickets[0]).to eq(ticket5)
      end 
    end 

    describe '#oldet_ticket' do
      it 'finds employees oldest ticket' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        susan = shoes.employees.create!(name:"Susan", level:5)
        ticket1 =susan.tickets.create!(subject:"Discounts", age:3)
        ticket2 =susan.tickets.create!(subject:"Remove signs", age:1)
        ticket3 =susan.tickets.create!(subject:"Update prices", age:2)
        ticket4 =susan.tickets.create!(subject:"Clean shelving", age:5)
        ticket5 = susan.tickets.create!(subject:"Change layout", age:4)

        expect(susan.oldest_ticket).to eq(ticket4)
      end 
    end 
  end

  describe 'class methods' do
    describe '#best_friends' do
      it 'finds other employees who share the same tickets' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        susan = shoes.employees.create!(name:"Susan", level:5)
        ticket1 = Ticket.create!(subject:"Discounts", age:3)
        EmployeeTicket.create!(ticket: ticket1, employee: susan)
        ticket2 = Ticket.create!(subject:"Remove signs", age:1)
        EmployeeTicket.create!(ticket: ticket2, employee: susan)

        mens = Department.create!(name:"Men's Clothing", floor:2)
        louis = mens.employees.create!(name:"Louis", level:2)
        EmployeeTicket.create!(ticket: ticket1, employee: louis)

        womens = Department.create!(name:"Women's Clothing", floor:1)
        alexa = womens.employees.create!(name:"Alexa", level:7)
        EmployeeTicket.create!(ticket: ticket2, employee: alexa)

        makeup = Department.create!(name:"Maekup", floor:1)
        blake = womens.employees.create!(name:"Blake", level:4)
        ticket3 = Ticket.create!(subject:"Clean shelving", age:5)
        EmployeeTicket.create!(ticket: ticket3, employee: blake)

        ticket_ids = susan.tickets.ids 

        expect(Employee.best_friends(susan.id, ticket_ids).count).to eq(2)
        expect(Employee.best_friends(susan.id, ticket_ids)[0]).to eq(louis)
      end 
    end 
  end 
end