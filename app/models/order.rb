class Order < ApplicationRecord
    has_one :payment, dependent: :destroy

    validates :external_id, presence: true, uniqueness: true

    enum status: {
        pending: "pending",
        processing: "processing",
        completed: "completed",
        failed: "failed",
        cancelled: "cancelled"
    }
end
