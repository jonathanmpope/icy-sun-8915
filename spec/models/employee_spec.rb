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
  end
end