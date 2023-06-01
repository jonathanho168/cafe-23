class PayGradesController < ApplicationController
    
    before_action :check_login
    before_action :set_pay_grade, only: [:show, :edit, :update]
    authorize_resource

    def index

    end

    def show
        @pay_grade_rate_history = @pay_grade.pay_grade_rates.chronological
    end

    def new
        # @pay_grade = PayGrade.new
    end

    def edit

    end

    def create
        @pay_grade = PayGrade.new(pay_grade_params)
        if @pay_grade.save
            redirect_to pay_grades_path
        else
            render action: 'new'
        end
    end

    def update
        if @pay_grade.update(pay_grade_params)
            redirect_to pay_grades_path
        else
            render action: 'edit'
        end
    end

    private

    def set_pay_grade
        @pay_grade = PayGrade.find(params[:id])
        if @pay_grade.nil?
            flash[:error] = "We apologize, but this information could not be found."
            redirect_to home_path
        end
    end

    def pay_grade_params
        params.require(:pay_grade).permit(:level, :active)
    end
end
