module Api::V1
  class ShiftStoreSerializer
    include FastJsonapi::ObjectSerializer
    set_type :store
    attributes :name
  end
end