json.array!(@orders) do |order|
  json.extract! order, :id, :address, :status, :total, :user_id
  json.url order_url(order, format: :json)
end
