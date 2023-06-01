module Api::V1
  class EmployeesController < ApiController

    before_action :set_employee, only: [:show, :update, :destroy]

    def index
      @employee = Employee.active.alphabetical

      render json: EmployeeSerializer.new(@employee).serialized_json

    end

    def show
      render json: EmployeeSerializer.new(@employee)
    end

    def new
      @employee = Employee.new
    end

    def edit

    end

    def create
      @employee = Employee.new(employee_params)

      if @employee.save
        render json: EmployeeSerializer.new(@employee), status: :created, location: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end

    def update
      if @employee.update(employee_params)
        render json: EmployeeSerializer.new(@employee)
      else
        render json: EmployeeSerializer.new(@employee).errors, status: :unprocessable_entity
      end
    end

    def destroy
      @employee.destroy
    end

    private 

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :username, :password_confirmation, :active)
    end
    
  end
end