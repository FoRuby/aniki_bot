module Debt::Operation
  class Update < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Debt::Contract::Update, builder: :default_contract!)
    step Contract::Validate()
    step Contract::Persist()
    step :assign_debt!

    def model!(options, params:, debt: nil, **)
      options[:model] = debt || Debt.find_by(creditor_id: params[:creditor_id], borrower_id: params[:borrower_id])
    end

    def assign_debt!(options, model:, **)
      options[:debt] = model
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, debt: options[:model])
    end
  end
end