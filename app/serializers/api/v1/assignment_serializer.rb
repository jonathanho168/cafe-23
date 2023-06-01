module Api::V1
  class AssignmentSerializer
    include FastJsonapi::ObjectSerializer
    attributes :store, :pay_grade, :as_of

    attribute :store do |a|
      a.store.name
    end

    attribute :pay_grade do |a|
      a.pay_grade.level
    end

    attribute :as_of do |a|
      humanize_date(a.start_date, :style => :full)
    end
  end
end