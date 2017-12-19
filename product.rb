id = params[:id]
product = ProductRepository.find_by_id(id)

ProductList.create!(
	id: evnet.data[:product_id],
	name: event.data[:name],
	price: BigDecimal.new(event.data[:price]),
)

ProductList.
	find_by!(id: event.data[:product_id])
update_attributes!(
	price: BigDecimal.new(event.data[:price])
)

ProductList.order("price DESC").limit(10)


