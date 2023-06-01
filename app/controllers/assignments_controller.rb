# module Api::V1
    class AssignmentsController < ApplicationController
        before_action :check_login
        before_action :set_assignment, only: [:show, :edit, :update, :destroy]
        authorize_resource

        def index
            if current_user.role == 'employee'
                @current_assignments = Assignment.current.for_employee(current_user)
                @past_assignments = Assignment.past.for_employee(current_user)
            else
                @current_assignments = Assignment.current
                @past_assignments = Assignment.past
            end
        end

        def show
        end

        def new
            @assignment = Assignment.new
        end

        def edit

        end

        def create
            @assignment = Assignment.new(assignment_params)
            if @assignment.save
                flash[:notice] = "Successfully added the assignment."
                redirect_to assignments_path
            else
                # @medicine = Medicine.find(params[:medicine_cost][:medicine_id])
                # render action: 'new', locals: { medicine: @medicine }
                render action: 'new'
            end
        end

        def update
            if @assignment.update(assignment_params)
                flash[:notice] = "Updated assignment information."
                redirect_to assignments_path
            else
                render action: 'edit'
            end
        end

        def destroy
            if @assignment.destroy
                flash[:notice] = "Removed assignment from the system."
                redirect_to assignments_path
            else
                render action: 'show'
            end
        end

        private

        def set_assignment
            @assignment = Assignment.find(params[:id])
        end

        def assignment_params
            params.require(:assignment).permit(:store_id, :employee_id, :pay_grade_id, :start_date, :end_date)
        end

    end
# end