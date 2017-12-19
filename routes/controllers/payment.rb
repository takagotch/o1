module Payments
	class AuthorizePaymentCommand
		include Command

		attr_accessor :order_number
		attr_accessor :total_amount
		attr_accessor :card_number

		validates_presence_of :order_number, :total_amount, :card_nubmer
	end
end

class PaymentReleased < RubyEventStore::Event
	SCHEMA = {
		tranaction_identifier: String,
		order_number: String,
	}.freeze

	def self.strict(data:)
	  ClassyHash.validate(data, SCHEMA, true)
	  new(data: data)
	end
end

