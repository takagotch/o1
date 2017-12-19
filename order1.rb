class SetDeliveryMethodAndConfirmCommand
	attr_accessor :order_number,
		      :delicery_method
end

class OrdersService
	def call(command)
		case command
		when SetDeliveryMethodAndConfirmCommand
			delivery_and_confirm(command)
		when ConfirmCommand
			confirm(command)
		when SetDeliveryMethodCommand
			set_delivery(command)
		else
			raise ArgumentError #ActiveRecord::IrreversibleMigration
		end
	end
	end

	private

	def delivery_and_confirm(command)
		with_order(command.order_number) do |order|
			order.set_delivery_method(command.delivery_method)
			order.confirm
		end
	end
end

class BatchOfComamnds
	attr_reader :commands

	def initialize
		@commands = []
	end

	def add_command(cmd)
		commands << cmd
		self
	end
end

class OrdersService
	def call(command)
		case command
		when BatchOfCommands
			batch(comamnd.commands)
		when Confirm(command)
			confirm(command)
		when SetDeliveryMethodCommand
			set_delivery(comamnd)
		else
			raise ArgumentError
		end
	end

	private
	def batch(commands)
		commands.each{|cmd| call(cmd)}
	end
end
batch = BatchOfCommands.new
batch.
	add_command(SetDeliveryMethodCommand.new(...)).
	add_command(ConfirmCommnad.new(...))
OrdersServiece.new.call(batch)




