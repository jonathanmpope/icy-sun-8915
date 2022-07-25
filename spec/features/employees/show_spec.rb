require 'rails_helper'

RSpec.describe 'the employee show page' do 
    it 'has a show page with name, departement and tickets' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        susan = shoes.employees.create!(name:"Susan", level:5)
        susan.tickets.create!(subject:"Discounts", age:3)
        susan.tickets.create!(subject:"Remove signs", age:1)
        susan.tickets.create!(subject:"Update prices", age:2)
        susan.tickets.create!(subject:"Clean shelving", age:5)
        susan.tickets.create!(subject:"Change layout", age:4)

        visit "/employees/#{susan.id}"

        expect(page).to have_content("Department: Shoes")
        expect(page).to have_content("Name: Susan")
        expect(page).to have_content("Tickets:")

        within ("#tickets") do 
            expect(page.all('.ticket')[0]).to have_content("Change layout")
            expect(page.all('.ticket')[1]).to have_content("Discounts")
            expect(page.all('.ticket')[2]).to have_content("Update prices")
            expect(page.all('.ticket')[3]).to have_content("Remove signs")
        end 

        within ("#oldest_ticket") do 
            expect(page).to have_content("Clean shelving")
        end 
    end 

    it 'can add a ticket that already exists to an employee' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        susan = shoes.employees.create!(name:"Susan", level:5)
        susan.tickets.create!(subject:"Discounts", age:3)
        susan.tickets.create!(subject:"Remove signs", age:1)
        susan.tickets.create!(subject:"Clean shelving", age:5)

        mens = Department.create!(name:"Men's Clothing", floor:2)
        louis = mens.employees.create!(name:"Louis", level:2)
        ticket = Ticket.create!(subject:"Change layout", age:2)
        EmployeeTicket.create!(ticket: ticket, employee: louis)

        visit "/employees/#{susan.id}"

        fill_in 'ticket_id', with: "#{ticket.id}"
        click_button 'Add Ticket'

        within ("#tickets") do 
            expect(page.all('.ticket')[1]).to have_content("Change layout")
        end 
    end 

      it 'can see a list of other employees that share tickets' do 
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

        visit "/employees/#{susan.id}"
        save_and_open_page

        expect(page).to have_content("Level: 5")

        within ("#best_friends") do 
            expect(page).to have_content("Name: Louis")
            expect(page).to have_content("Name: Alexa")
        end 
    end 
end 