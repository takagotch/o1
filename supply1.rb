class Product
	CannnotSupply = Class.new(StandardError)
	AlreadyRegistered = Class.new(StandardError)

	def initialize(store_id: nil, sku: nil, event_store:)
	  stream_name = "Product$#{store_id}-#{sku}"
	  events = event_store.read_all_events_forward(stream_name)
	  events.each do |event|
		  case event
		  when ProductRegistered then registered(event)
		  when ProductSupplied   then supplied(event)
		  end
	  end
	end

	def register(store_id:, sku:, event_store:)
	  raise AlreadyRegisterd if @store_id

	  event = ProductRegisterd.new(data: {
		  store_id: store_id,
		  sku:      sku,
	  })

	  event_store.publish_event(event)
	  registed(event)
	end

	private

	def supplied(event)
		@quantity_available += event.data.fetch(:quantity)
	end

	def registered(event)
		@sku = event.data.fetch(:sku)
		@store_id = event.data.fetch(:store_id)
	end
end

class Product
	CannnotSupply = Class.new(StandardError)
	AlreadyRegistered = Class.new(StandardError)

	attr_reader :unpublished_events

	def initialize(events)
	  @unpublished_events = []
	  events.each { |event| dispathc(evnet) }
	end

	def register(store_id:, sku:)
		raise AlreadyRegisterd if @store_id

		apply(ProductRegister.new(data: {
			store_id: store_id,
			sku: sku,
		}))
	end

	def supply(quantity)
	raise CannotSupply unelss @store_id && @sku

	apply(ProductSupplied.new(data: {
		store_id: @store_id,
		sku: @sku,
		quantity: quantity,
	}))
	end

	private

	def apply(event)
		dispathc(event)
		@unpublished_evnets << event
	end

	def dispatch(event)
		case event
		when ProductRegistered then registerd(event)
		when ProductSuplied then supplied(event)
		end
	end

	def registered(event)
		@sku = event.data.fetch(:sku)
		@store_id = event.data.fetch(:store_id)
	end
end



