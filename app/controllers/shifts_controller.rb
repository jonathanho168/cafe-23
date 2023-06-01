class ShiftsController < ApplicationController
    before_action :check_login

    before_action :set_shifts, only: [:show, :edit, :update, :destroy]
    authorize_resource

    def index
        if current_user.admin_role?
            @upcoming_shifts = Shift.upcoming.chronological
            @completed_shifts = Shift.completed.chronological
        elsif current_user.manager_role?
            @upcoming_shifts = Shift.for_store(current_user.current_assignment.store).upcoming.chronological
            @completed_shifts = Shift.for_store(current_user.current_assignment.store).completed.chronological
        else
            # @upcoming_shifts = nil
            # @completed_shifts = nil
        end
    end

    def show

    end

    def new
        @shift = Shift.new
    end

    def edit

    end

    def create
        @shift = Shift.new(shift_params)
        if @shift.save
            redirect_to shift_path(@shift)
        else
            render action: 'new'
        end
    end

    def update
        if @shift.update(shift_params)
            redirect_to shift_path(@shift)
        else
            render action: 'edit'
        end
    end

    def destroy
        if @shift.destroy
            redirect_to shifts_path
        else
            render action: 'show'
        end
    end



    def time_clock

        today = DateRange.new(Date.current, Date.current)
        work = Shift.for_employee(current_user).for_dates(today).first

        if work.nil?
            redirect_to home_path, notice: "You do not have any shifts today"

        else 
            @shift_today = work
        end
    end

    def time_in
        today = DateRange.new(Date.current, Date.current)
        work = Shift.for_employee(current_user).for_dates(today).first
        if work.nil?
            redirect_to home_path, notice: "You do not have any shifts today"
        else
            @shift_clock = TimeClock.new(work)
            @shift_clock.start_shift_at()
            redirect_to home_path, notice: "Your shift has started."
        end

    end

    def time_out
        today = DateRange.new(Date.current, Date.current)
        work = Shift.for_employee(current_user).for_dates(today).first
        if work.nil?
            redirect_to home_path, notice: "You do not have any shifts today"
        else
            @shift_clock = TimeClock.new(work)
            @shift_clock.end_shift_at()
            redirect_to home_path, notice: "Your shift has ended."

        end
    end

    private

    def set_shifts
        @shift = Shift.find(params[:id])
        if @shift.nil?
            flash[:error] = "We apologize, but this information could not be found."
            redirect_to home_path
        end

    end

    def shift_params
        params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end


    
end
