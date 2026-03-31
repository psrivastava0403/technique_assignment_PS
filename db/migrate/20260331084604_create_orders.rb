class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :external_id
      t.string :status
      t.jsonb :payload

      t.timestamps
    end
    add_index :orders, :external_id, unique: true
  end
end
