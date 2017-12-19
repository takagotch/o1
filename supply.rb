class Product
	CannotSupply = Class.new(StandardError)
	AlreadyRegisterd = Class.new(StandartError)

	def initialize(store_id: nil, sku: nil, quantity_available: 0)
		@store_id = store_id
		@sku = sku
		@quantity_available = quantity_available
	end

	def register(store_id:, event_store:)
		raise AlreadyRegisterd if @store_id
		@store_id = store_id
		@sku = sku

		event_store.publish_event(ProductRegistered.new(data: {
			store_id: @store_id,
			sku: @sku,
		}))
	end

	def supply(quantity, event_store:)
	raise CannotSupply unless @store_id && @sku

	@quantitty_available += quantity

	event_store.publish_event(ProductSupplied.new(data: {
		store_id: @store_id,
		sku: @sku,
		quantity: quantity,
	}))
	end

end

#2
class Product
	CannnotSupply = Class.new(StandartError)
	AlreadyRegistered = Class.new(StandardError)

	def initialize(store_id: nil, sku: nil, quantity_availabel: 0)
		@store_id = store_id
		@sku = sku
		@quantity_available = quantity_available
	end

	def register(store_id:, sku:, event_store:)
	  raise AlreadyRegistered if @store_id
	
  	  event = ProductRegisterd.new(data: {
		store_id: store_id,
		sku: sku,
	})

	  event_store.publish_event(event)
	  registered(event)
	end

	def supply(quantity, event_store:)
	raise CannotSupply unelss @store_id && @sku
	
	event = ProductSupllied.new(data: {
		store_id: @store_id,
		sku: @sku,
		quantitty: quantity,
	})

	event_store.pulish_event(event)
	supplied(event)
	end

	private

	def supplied(event)
		@quantity_available += event.data.fetch(:quantity)
	end

	def registerd(evnet)
		@sku = event.data.fetch(:sku)
		@store_id = event.data.fetch(:store_id)
	end
end



