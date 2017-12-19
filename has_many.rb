class AccountTransaction < ActiveRecord::Base
	has_many :deposits

	has_many :withdrawals, -> { where(deleted:false) }
	has_many :amounts,     -> { order(create_at: :desc) }
end



deposits = accounttransaction.deposits

accounttransaction.deposits <<(deposit1, deposit2, ...)

accounttransaction.deposits.delete(deposit1, deposit2, ...)

accounttransaction.deposits.destroy(deposit1, deposit2, ...)

accounttransaction.deposits = new_deposits

ids = accounttransaction.deposit_ids

accounttransaction.deposit_ids = new_ids_array

accounttransaction.deposits.clear

accounttransaction.empty?

accounttransaction.size

deposit = accounttransaction.deposits.find(1)

accounttransaction.deposits.exsist?(made_in: "Japan")

accounttransaction.deposits.build(size: 20, made_in: "Japan")

accounttransaction.deposits.create(size: 20, made_in: "Japan")

accounttransaction.deposits.create!(size: 20, made_in: "Japan")


