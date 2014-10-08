class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :card_type
      t.integer :card_number
      t.integer :cvv
      t.integer :month
      t.integer :year
      t.boolean :status
      t.decimal :amount, precision: 10, scale: 0
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
