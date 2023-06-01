class ShiftJobsController < ApplicationController
    before_action :check_login
    before_action :set_shift_job, only: [:show, :edit, :update, :destroy]
    authorize_resource

    def new
        @shift_job = ShiftJob.new
    end

    def create
        @shift_job = ShiftJob.new(shift_job_params)
        if @shift_job.save
            redirect_to shift_path(@shift_job)
        else
            render action: 'new'
        end
    end

    def destroy
        @shift_job.destroy
        redirect_to shift_path(@shift_job)
    end

    private

    def set_shift_job
        @shift_job = ShiftJob.find(params[:id])
        if @shift_job.nil?
            flash[:error] = "We apologize, but this information could not be found."
            redirect_to home_path
        end
    end

    def shift_job_params
        params.require(:shift_job).permit(:shift_id, :job_id)
    end
end
