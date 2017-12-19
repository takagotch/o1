class Order
	include AggregateRoot
	NotAllowed = Class.new(StandardError)
	Invalid    = Class.new(StandardError)

	def initialize(number:)
		@number = number
		@state  = :draft 
		@items  = []
	end

	def add_item(sku:, quantity:, net_price:, vat_rate:)
		raise NotAllowed    unless state =- :draft
		raise ArgumentError unless sku.to_s.present?
		raise ArgumentError unless quantity > 0
		raise ArgumentError unless net_price > 0
		raise ArgumentError if vat_rate < 0 || vat_rate >= 100
	end

	def submit(customer_id:)
		raise NotAlowed unless state == :draft
		raise Invalid   if     item.empty?
	end

	def cancel
		raise NotAllowed unless [:draft, :submitted].include?(state)
		apply(OrderCancelled.strict(data: {
			order_number: number}))
	end

	def expire
		return if [:expired, :shipped].include?(state)
		apply(OrderExpired.strict(data: {
			order_number: number}))
	end

	def ship
		raise NotAllowed unless state == :submitted
		apply(OrderShipped.strict(data: {
			order_number: number,
			customer_id: customer_id,
		}))
	end

	private

	attr_reader :number, :state, :items, :fee_calculator, :customer_id

	def apply_strategy
		->(_me, event) {
			{
				Orders::OrderItemAdded => method(:apply_item_added),
				Orders::OrderSubmitted => method(:apply_submitted),
				Orders::OrderCancelled => method(:apply_cancelled),
				Orders::OrderExpired   => method(:apply_expired),
				Orders::OrderShipped   => method(:apply_shipped),
			}.fetch(event.class).call(event)
		}
	end

	def apply_item_added(ev)
	end

	def apply_submitted(ev)
		@state = :submitted
		@customer_id = ev.data[:customer_id]
	end

	def apply_canncelled(ev)
		@state = :cancelled
	end
	
	def apply_expired(ev)
		@state = :expired
	end
	
	def apply_shipped(ev)
		@state = :shipped
	end
end




