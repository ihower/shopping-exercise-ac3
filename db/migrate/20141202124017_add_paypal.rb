class AddPaypal < ActiveRecord::Migration
  def change

    # Step1: Create Payment
    add_column :orders, :paypal_payment_id, :string
    add_column :orders, :paypal_state, :string
    add_column :orders, :paypal_create_time, :datetime
    add_column :orders, :paypal_update_time, :datetime

    add_column :orders, :paypal_approval_url, :string
    add_column :orders, :paypal_execute_url, :string

    add_column :orders, :paypal_error, :text

    # Step2: Get payment approval
    add_column :orders, :paypal_payer_id, :string
    add_column :orders, :paypal_return_at, :datetime

    add_index :orders, :paypal_payment_id
  end

end
