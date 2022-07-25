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

end 