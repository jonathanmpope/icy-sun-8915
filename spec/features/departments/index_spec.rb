require 'rails_helper'

RSpec.describe 'the department index page' do 
    it 'has a list of all departments with their info' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        mens = Department.create!(name:"Men's Clothing", floor:2)
        womens = Department.create!(name:"Women's Clothing", floor:1)

        visit '/departments'

        expect(page).to have_content("Department: Shoes")
        expect(page).to have_content("Floor: 3")
        expect(page).to have_content("Department: Men's Clothing")
        expect(page).to have_content("Floor: 2")
        expect(page).to have_content("Department: Women's Clothing")
        expect(page).to have_content("Floor: 1")
        expect(page).to_not have_content("Department: Makeup")
    end 

    it 'has a list of all departments with employees info' do 
        shoes = Department.create!(name:"Shoes", floor:3)
        shoes.employees.create!(name:"Susan", level:5)
        shoes.employees.create!(name:"Grant", level:2)
        mens = Department.create!(name:"Men's Clothing", floor:2)
        mens.employees.create!(name:"Louis", level:2)
        womens = Department.create!(name:"Women's Clothing", floor:1)
        womens.employees.create!(name:"Alexa", level:7)
        womens.employees.create!(name:"Andrea", level:5)

        visit '/departments'
        save_and_open_page

        within ("#departments") do 
            expect(page.all('.department')[0]).to have_content("Susan")
            expect(page.all('.department')[0]).to have_content("Grant")
            expect(page.all('.department')[1]).to have_content("Louis")
            expect(page.all('.department')[2]).to have_content("Alexa")
            expect(page.all('.department')[2]).to have_content("Andrea")
        end 
    end

end 