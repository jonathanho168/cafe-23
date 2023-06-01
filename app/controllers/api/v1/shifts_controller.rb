module Api::V1
  class ShiftsController < ApiController
    before_action :set_shift, only: [:show, :update, :destroy]

    def index
      @shifts = Shift.active.alphabetical

      render json: ShiftSerializer.new(@shift).serialized_json

    end

    def show
      render json: ShiftSerializer.new(@shift)
    end

    def new
      @shift = Shift.new 
    end

    def edit

    end

    def create
      @shift = Shift.new(shift_params)

      if @shift.save
        render json: ShiftSerializer.new(@shift), status: :created, location: @shift
      else
        render json: @shift.errors, status: :unprocessable_entity
      end
    end

    def update
      if @shift.update(shift_params)
        render json: ShiftSerializer.new(@shift)
      else
        render json: @shift.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @shift.destroy
    end

    def upcoming
      @shift = Shift.for_next_days(7).select{
        |s| s.store_id == params[:id].to_i
      }.sort_by{
        |s| [s.date, s.start_time]
      }
      render json: ShiftUpcomingSerializer.new(@shift)
    end

    private 

    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      # params.permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :username, :password_confirmation, :active)
      params.permit(:name, :street, :city, :phone, :zip, :state, :phone, :active)
    end


  end
end