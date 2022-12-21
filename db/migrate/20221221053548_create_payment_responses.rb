class CreatePaymentResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_responses do |t|
      t.column :transation_id, :string
      t.column :amount, :decimal
      t.column :user_id, :string
      t.column :pay_response, :text
      t.timestamps
    end
  end
end
