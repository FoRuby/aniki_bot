module Refill::Operation
  class Create < Trailblazer::Operation
    step Model(Refill, :new)
    step Contract::Build(constant: Refill::Contract::Base)
    step Contract::Validate()
    step Contract::Persist()
    step :update_debt!
    step :update_status!

    def update_debt!(options, model:, **)
      operation = Debt::Operation::UpdateFromRefill.call(refill: model, params: { debt: model.value })
      options[:debt] = operation[:model]
      operation.success?
    end

    def update_status!(options, model:, **)
      model.update(status: :completed)
    end
  end
end