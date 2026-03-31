class Payment < ApplicationRecord
  belongs_to :order

  validates :idempotency_key, presence: true, uniqueness: true

  enum status: {
      pending: "pending",
      processing: "processing",
      completed: "completed",
      failed: "failed",
      cancelled: "cancelled"
  }
end
