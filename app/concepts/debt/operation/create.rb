module Debt::Operation
  class Create < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Debt::Contract::Base)
    step Contract::Validate()
    step Contract::Persist()

    def model!(options, params:, **)
      options[:model] = Debt.find_by(creditor: params[:creditor], borrower: params[:borrower])
      options[:model] = Debt.new unless options[:model]
      true
    end
  end
end