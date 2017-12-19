class withdrawal < ActiveRecord::Base
  belongs_to :deposit_and_withdrawal

  belongs_to :basic_income_account, ->{ where(delete: false)}
end

deposit_and_withdrawal = withdrawal.deposit_and_withdrawal

withdrawal.deposit_and_withdrawal = deposit_and_withdrawal

withdrawal.build_deposit_and_withdrawal(name: "AccountTransaction")

withdrawal.create_deposit_and_withdrawal(name: "AccountTransaction")

withdrawal.create_deposit_and_withdrawal(name: "AccountTransaction")

