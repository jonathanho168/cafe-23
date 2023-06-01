module Api::V1
    class ShiftEmployeeSerializer
        include FastJsonapi::ObjectSerializer
        set_type :employee
        attributes :name

        attribute :role do |e| 
            e.role.capitalize
        end

        attribute :pay_grade do |e|
            e.current_assignment.pay_grade.level
        end

        attribute :pay_rate do |e|
            e.current_assignment.pay_grade.current_rate.rate
        end

        attribute :over_18 do |e|
            e.over_18?
        end
    end
end