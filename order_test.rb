RSpec.describe Controller::MyCommand do
include_examples "ApplicationService::MyCommand"
end

class TestMeme < Minitest::Test
	include ApplicationService::MyCommandLint

	def setup
		@command = Controller::MyCommand.new
	end
end

class Controller < ApplicationController
	def create
		cmd = MyCommand.new
		cmd.user_id = session.fetch(:user_id)
		cmd.product_id = params.fetch(:product).fetch(:id)
		ApplicationService.new.call(cmd)
		head :ok
	end
end

#2
class Controller < ApplicationController
def create
	cmd = MyCommand.new(
		user_id: session.fetch(:user_id)
		product_id: params.fetch(:product).fetch(:id)
	)
	ApplicationService.new.call(cmd)
	head :ok
end
end

