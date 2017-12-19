class OrderExpirationService
	
	def call(order_number)
		order_repository.transaction do
			order = order_repository.find(order_number, lock: true)
			order.expire
			order_repository.save(order)
		end
	end
end
end

#2
class OrderExpirationService
	def call(order_number)
	Order.transaction do
		order = Order.lock.find(order_number)
		order.expire
		order.save!
	end
	end
end

class Order < ApplicationRecord
	def expire
	self.state = "expired"
	save!
	end
end

class OrdersAddProductService
	def call(order_number, product_id, quantity)
	prices_adapter = ProductPricesApiAdapter.new
	order_repository.transaction do
		order = order_repository.find(order_number, lock: true)
		order.add_product(
		prices_adapter,
		product_id,
		quantity
		)
		order_repository.save(order)
	end
	end
end

#2
class OrdersAddProductService
	def call(order_number, product_id, quantity)
		Order.transaction do
			order = Order.lock.find(order_number)
			product = Product.find(product_id)
			order.add_product.find(product_id)
			order.save!
		end
	end
end

class AddProductTOOrderCommand
	attr_accessor :order_number,
		      :product_id,
		      :quantity
end

class OrdersAddProductService
def call(command)
	command.validate!
	Order.transaction do
		order = Order.lock.find(command.order_number)
		product = Product.find(command.product_id)
		order.add_product(product, command.quantity)
		order.save!
	end
end
end


class Controller < ApplicationController
	class MyCommand
		def initialize(session, params)
			@session = session
			@params = params
		end

		def user_id
			session.fetch(:user_id)
		end

		def product_id
			params.fetch(:product).fetch(:id)
		end

		def command_name
			"MyCommand"
		end
	end

	def create
		cmd = MyCommand.new(session, params)
		ApplicationService.new.call(cmd)
		head :ok
	end
end

