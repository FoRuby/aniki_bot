module Debt::Operation
  class Create < Trailblazer::Operation
    step :model!
    step Wrap(Shared::Macro::Transaction) {
      step :new?, Output(:failure) => Id(:create_refill!)
      step Contract::Build(constant: Debt::Contract::Create)
      step Contract::Validate()
      step Contract::Persist()
      step Subprocess(::Refill::Operation::Create), id: :create_refill!

      fail Shared::Macro::Rollback
    }

    def model!(options, params:, **)
      options[:model] = options[:debt] = Debt.find_or_initialize_by(creditor: params[:creditor], borrower: params[:borrower])
    end

    def new?(options, debt:, **)
      debt.new_record?
    end
  end
end
