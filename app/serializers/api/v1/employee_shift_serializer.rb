module Api::V1
  class EmployeeShiftSerializer
    include FastJsonapi::ObjectSerializer
    set_type :shift
    attributes :date, :status
    attribute :start_time do |t| 
      humanize_time(t.start_time, :ampm => false)
    end

    attribute :end_time do |t|
      humanize_time(t.end_time, :ampm => false)
    end

  end
end