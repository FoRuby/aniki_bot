module Debt::Operation
  class Refill < Trailblazer::Operation
    step :debt!
    step Contract::Build(constant: Debt::Contract::Update, builder: :default_contract!)
    step :prepopulate!
    step Contract::Validate()
    step Contract::Persist()

    def debt!(options, params:, debt: nil, **)
      options[:model] = debt || Debt.find_by(creditor_id: params[:creditor_id], borrower_id: params[:borrower_id])
    end

    def prepopulate!(options, model:, params:, **)
      options[:'contract.default']
        .prepopulate!(refills: [{ debt_id: model.id, value: -1 * params[:value], status: :created }])
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, debt: options[:model])
    end
  end
end