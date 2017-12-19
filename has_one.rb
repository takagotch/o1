class IncomeAccount < ActiveRecord::Base
  has_one :withdrawals
end

withdrawals = IncomeAccount.withdrawal

IncomeAccount.withdrawal = withdrawal

IncomeAccount.build_withdrawal(number: "withdrawal_account_id")

IncomeAccount.create_withdrawal(number: "withdrawal_account_id")

IncomeAccount.create_withdrawal(number: "withdrawal_account_id")

