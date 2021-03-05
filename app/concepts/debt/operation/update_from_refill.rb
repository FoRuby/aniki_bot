module Debt::Operation
  class UpdateFromRefill < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Debt::Contract::UpdateFromRefill)
    step Contract::Validate()
    step Contract::Persist()

    def model!(options, refill:, **)
      options[:model] = Debt.find_by(creditor: refill.to_user, borrower: refill.from_user)
      options[:model] = Debt.new(creditor: refill.to_user, borrower: refill.from_user) unless options[:model]
      true
    end
  end
end