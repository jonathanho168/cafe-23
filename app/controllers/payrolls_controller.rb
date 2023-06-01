class PayrollsController < ApplicationController
    before_action :check_login
    # before_action :check_role, only: [:store_form, :employee_form]
    # before_action :set_calculate, only: [:employee_payroll, :store_payroll]

    # authorize_resource

    def store_form
        authorize! :store_form, :payrolls_controller
        # if current_user.employee_role?
        #     redirect_to home_path
        # end
    end

    def employee_form
        authorize! :employee_form, :payrolls_controller
        # if current_user.manager_role?
        #     redirect_to home_pathrail
        # end

        @employees = Employee.active.alphabetical.to_a

    end



    def employee_payroll
        authorize! :employee_payroll, :payrolls_controller

        # @start_date = params[:start_date].to_date
        # @end_date = params[:end_date].to_date
        # @daterange = DateRange.new(@start_date, @end_date)
        # puts "first"
        @date_range = DateRange.new(params[:start_date].to_date, params[:end_date].to_date)
        @calculator = PayrollCalculator.new(@date_range)
        
        # puts "second"
        @employee = Employee.find(params[:employee_id])

        # if @employee.nil?
        #     puts "2.5"
        # else 
        #     puts "2.75"
        # end
        @employee_payroll = @calculator.create_payroll_record_for(@employee)

        # puts "third"
    end

    def store_payroll
        authorize! :store_payroll, :payrolls_controller

        # @start_date = params[:start_date].to_date
        # @end_date = params[:end_date].to_date
        # @daterange = DateRange.new(@start_date, @end_date)
        @date_range = DateRange.new(params[:start_date].to_date, params[:end_date].to_date)
        @calculator = PayrollCalculator.new(@date_range)
        if current_user.admin_role?

            @store = Store.find(params[:store_id])
            

        else
            @store = current_user.stores.first

        end

        @store_payroll = @calculator.create_payrolls_for(@store)
    end

    private

    def check_role
        unless current_user.admin_role? || current_user.manager_role?
            redirect_to home_path
        end
    end

    # def set_calculate
    #     @calculator = PayrollCalculator.new(DateRange.new(params[:start_date].to_date, params[:end_date].to_date))
    # end

end
