module Refill::Operation
  class Rollback < Refill::Operation::Perform
    def add_params!(options, params:, refill:, **)
      params[:value] = refill.value * -1
    end

    def update_refill!(options, **)
      options[:refill].update(status: :rollback)
    end
  end
end