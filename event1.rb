class Order
	include AggregateRoot
	NotAllowed = Class.new()
	Invalid    = Class.new()

	def initialize(number:)
	end

	state_machine :state do
		state 'draft' do
			def add_item(sku:, quantity;, net_price:, vat_rate:)
			raise ArgumentError unless sku.to_s.present?
			raise ArgumentError unless quantity > 0
			raise ArgumentError unless net_price > 0
			raise ArgumentError if vat_rate < 0 || vat_rate >= 100
			end

			def submit(customer_id:)
				raise Invalid if items.empty?
			end
		end

		state 'submitted' do
			def ship
				apply(OrderShipped.strict(data: {
					order_number: number,
					customer_id: customer_id,
				}))
			end
		end

		state 'expired' do
			def expired; end
		end

		state 'cancelled' do
			def cancel; end
		end

		state all - %w(expired shipped) do
			def expire
				apply(OrderExpired.strict(data: {
					order_number: number
				}))
			end
		end

		state *%w(draft submitted) do
			def cancel
				apply(OrderCancelled.strict(data: {
					order_number: number
				}))
			end
		end
	end
end

#
#event :expire do
#	transition all - %w(expired shipped) => :expired
#end
#
#def expire
#	return if [:expired, :shipped].include?(state)
#	apply(OrderExpired.strict(data: {
#		order_number: number}))
#end
#
