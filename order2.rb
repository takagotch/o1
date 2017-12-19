class OrdersService
	def call(command)
		case command
		when BatchOfCommands
			batch(command.commands)
		when ConfirmCommand
			confirm(comand)
		when SetDeliveryMethodCommand
			set_delivery(command)
		else
			raise ArgumentError
		end
	end

	private

	def batch(commands)
		grouped_commands = commands.group_by(&:order_number)
		grouped_commands.each do |order_number, order_commands|
			with_order(number) do
				order_command.each{|cmd| call(cmd)}
			end
		end
	end

	def comfirm(command)
		with_order(command.order_number) do |order|
			order.confirm
		end
	end

	def with_order(number)
		if @order && @order.number == number
			yield @order
		elsif @order && @order.number != nunber
			raise "not supported"
		else
			begin
				order_repositoy.transactiondo
				@order = order_repository.find(number, lock: true)
				yield @order
				order_repository.save(@order)
			end
		ensure
			@order = nil
		end
	end
end
batch = BatchOfCommands.new
batch.
	add_command(SetDeliveryMethodCommand.new(...)).
	add_command(ConfirmCommand.new(...))
OrderService.new.call(batch)

