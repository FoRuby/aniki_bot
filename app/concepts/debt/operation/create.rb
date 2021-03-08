module Debt::Operation
  class Create < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Debt::Contract::Base)
    step Contract::Validate()
    step Contract::Persist()

    def model!(options, params:, **)
      options[:model] = Debt.find_or_initialize_by(creditor: params[:creditor], borrower: params[:borrower])
    end
  end
end