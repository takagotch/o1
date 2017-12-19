validates :user_id, format: { with: /\A[A-Za-z]+\z/,
  message: "write in half-width alphabet"}

validates :password, presence: { on: :create }

validates :name, length: { minimum: 2, allow_blank: true }

validates :password, presence: { if: :password_requested }
validates :password, presence: { if: ->(member){ member.password_required } }

validates :password, presence: { strict: true }

validates :terms_of_service, acceptance: { accept: "yes" }

validates :password, confirmation: true

validates :amount, format: { with: /\A[A-Za-z]+\z/ }

validates :name, format: { with: ->(member){
  member.administrator? ? /\A[A-Za-z0-9]\z/ : /\A[A-Za-z]+\z/ } }

validates :names, format: { with: , multiline: true }

validates :account_number, inclusion: { in: (1..100) }

validates :status, inclusion: { in: %w(draft member_only public) }

validates :name, lenght: { maximum: 20 }

validates :balance, numericality: { greater_than_or_equal_to: 0.00 }

validates :name, presence: true

validates :name, absense: true

validates :deposit_account_id, uniqueness: { case_sensitive: false }

validates :withdrawal_account_id, uniqueness: { scope: "group_id" }

validates :name, uniqueness: { conditions: ->{ where(deleted: falese) } }

