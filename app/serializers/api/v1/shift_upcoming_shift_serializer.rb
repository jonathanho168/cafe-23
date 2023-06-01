module Api::V1
    class ShiftUpcomingShiftSerializer
        include FastJsonapi::ObjectSerializer
        set_type :shift

        attribute :employee do |s|
            ShiftEmployeeSerializer.new(s.employee)
        end

        attributes :date
        
        attribute :start_time do |t| 
            humanize_time(t.start_time, :ampm => false)
        end

        attribute :end_time do |t|
            humanize_time(t.end_time, :ampm => false)
        end

    end

end