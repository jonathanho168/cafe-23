module Api::V1
  class EmployeeSerializer
    include FastJsonapi::ObjectSerializer
    extend ActionView::Helpers::NumberHelper
    attributes :name
    # has_many :assignments 
    # has_many :stores, through: :assignments
    # has_many :shifts, through: :assignments 
    # has_many :pay_grades, through: :assigignments
    # has_many :pay_grade_rates, through: :pay_grades


    attribute :phone do |employee| 
      number_to_phone(employee.phone)
    end

    attributes :age

    attribute :role do |employee| 
      employee.role.capitalize
    end

    attribute :current_assignment do |employee|
      AssignmentSerializer.new(employee.current_assignment)
    end

    attribute :recent_shifts do |employee|
      employee.shifts.for_past_days(7).map do |shift|
          EmployeeShiftSerializer.new(shift)
      end

    end


  end
end