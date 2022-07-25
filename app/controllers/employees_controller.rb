class EmployeesController < ApplicationController

    def show 
        @employee = Employee.find(params[:id])
        ticket_ids = @employee.tickets.ids 
        @best_friends = Employee.best_friends(params[:id], ticket_ids)
    end 

    def update 
        new_ticket = Ticket.find(params[:ticket_id])
        new_employee = Employee.find(params[:id])
        EmployeeTicket.create!(ticket: new_ticket, employee: new_employee)
        redirect_to "/employees/#{new_employee.id}"
    end 

end 