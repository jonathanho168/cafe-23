module Api::V1

  class ShiftSerializer
    include FastJsonapi::ObjectSerializer
    # attributes :store, :date, :employee, :start_time, :end_time, :duration, :report_completed, :jobs_worked
    # belongs_to :assignment
    # has_one :employee, through: :assignment
    # has_one :store, through: :assignment
    # has_many :shift_jobs #, dependent: :destroy
    # has_many :jobs, through: :shift_jobs

    attribute :store do |s|
      ShiftStoreSerializer.new(s.store)
    end

    attribute :employee do |e|
      ShiftEmployeeSerializer.new(e.employee)
    end

    attributes :date

    attribute :start_time do |t|
      humanize_time(t.start_time, :ampm => false)
    end

    attribute :end_time do |t|
      humanize_time(t.end_time, :ampm => false)
    end

    attribute :duration do |s|
      s.duration
    end

    attribute :report_completed do |s|
      s.report_completed?
    end

    attribute :jobs_worked do |s|
      s.jobs.map do |j|
        j.name
      end
    end
  end
end