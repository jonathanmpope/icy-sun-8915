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


end 