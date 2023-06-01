class EmployeesController < ApplicationController
    before_action :check_login
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    authorize_resource

    def index
        if current_user.role == "manager"
            @active_employees = current_user.current_assignment.store.employees.active
            @inactive_employees = current_user.current_assignment.store.employees.inactive
        else
            @active_employees = Employee.active
            @inactive_employees = Employee.inactive
        end
    end

    def show
        @current_assignment = @employee.current_assignment
        @other_assignments = Assignment.past.for_employee(@employee)
    end

    def new
        @employee = Employee.new
    end

    def edit

    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            flash[:notice] = "Successfully added #{@employee.proper_name} as an employee."
            redirect_to employee_path(@employee)
        else
            # @medicine = Medicine.find(params[:medicine_cost][:medicine_id])
            # render action: 'new', locals: { medicine: @medicine }
            render action: 'new'
        end
    end

    def update
        if @employee.update(employee_params)
            flash[:notice] = "Updated #{@employee.proper_name}'s information."
            redirect_to employee_path(@employee)
        else
            render action: 'edit'
        end
    end

    def destroy
        if @employee.destroy
            redirect_to employees_path
        else
            render action: 'show'
        end
    end

    private

    def set_employee
        @employee = Employee.find(params[:id])

        if @employee.nil?
            flash[:error] = "We apologize, but this information could not be found."
            redirect_to home_path
        end            
    end

    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :username, :password, :password_confirmation, :active)
    end

end
