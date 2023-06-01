module Api::V1
    class ShiftUpcomingSerializer
        include FastJsonapi::ObjectSerializer
        
        attribute :store do |shift|
            shift.store.name
        end

        attribute :shifts do |shift|
            ShiftUpcomingShiftSerializer.new(shift)
        end
    end
end