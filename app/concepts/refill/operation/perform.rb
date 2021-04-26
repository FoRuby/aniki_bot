module Refill::Operation
  class Perform < Trailblazer::Operation
    step :model!
    step :debt!
    step :add_params!
    step Subprocess(Debt::Operation::Update)
    step :update_refill!

    def model!(options, model: nil, params: {}, **)
      options[:model] = options[:refill] = model || Refill.find_by(id: params[:id])
    end

    def debt!(options, refill:, debt: nil, **)
      options[:debt] = debt || refill.debt
    end

    def add_params!(options, params:, refill:, **)
      params[:value] = refill.value
    end

    def update_refill!(options, model:, **)
      options[:refill].update(status: :completed)
    end
  end
end