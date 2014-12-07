class AddFakecardToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fakecard, :text
  end
end
