class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :status, default: "pending"
      t.string :idempotency_key, null: false
      t.integer :retry_count, default: 0
      t.string :error_message
      t.jsonb :details

      t.timestamps
    end
    add_index :payments, :idempotency_key, unique: true
  end
end
