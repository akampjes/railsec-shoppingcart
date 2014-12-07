class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.text :status
      t.decimal :total
      t.references :user, index: true

      t.timestamps
    end
  end
end
