class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.string :payment_type

      t.string :receive_name
      t.string :receive_address

      t.integer :total

      t.integer :user_id


      t.timestamps
    end
  end
end
