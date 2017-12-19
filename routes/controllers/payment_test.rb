module Orders
	Rspec.describe Order do
		it '' do
			order = Order.new(number: 'xxxx')
			expect{ order.expire }.not_to raise_error
			expect(order).to publish [
				OrderExpired.strict(data: { order_number: 'xxxx' }),
			]
		end
	end
end
