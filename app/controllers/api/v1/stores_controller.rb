module Api::V1
  class StoresController < ApiController
    # before_action :set_store, only: [:show, :update, :destroy]

    # def index
    #   @stores = Store.active.alphabetical

    #   render json: StoreSerializer.new(@store).serialized_json

    # end

    # def show
    #   render json: StoreSerializer.new(@store)
    # end

    # def edit

    # end

    # def create
    #   @store = Store.new(store_params)

    #   if @store.save
    #     render json: StoreSerializer.new(@store), status: :created, location: @store
    #   else
    #     render json: @store.errors, status: :unprocessable_entity
    #   end
    # end

    # def update
    #   if @store.update(store_params)
    #     render json: StoreSerializer.new(@store)
    #   else
    #     render json: @store.errors, status: :unprocessable_entity
    #   end
    # end

    # def destroy
    #   @store.destroy
    # end

    # private 

    # def set_store
    #   @store = Store.find(params[:id])
    # end

    # def store_params
    #   # params.permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :username, :password_confirmation, :active)
    #   params.permit(:date, :start_time, :end_time, :notes, :status)
    # end


  end
end