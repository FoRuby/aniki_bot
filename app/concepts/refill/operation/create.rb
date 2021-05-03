module Refill::Operation
  class Create < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Refill::Contract::Base)
    step Contract::Validate()
    step Contract::Persist()
    step Subprocess(::Refill::Operation::Perform)

    def model!(options, debt: nil, **)
      options[:model] = debt ? debt.refills.new : Refill.new
    end
  end
end