module Debt::Operation
  class Compensation < Trailblazer::Operation
    step :opponent!
    step :debt1!
    step :debt2!
    step :update_debt1
    step :consent?
    step :compensate
    step :refill_debts

    def opponent!(options, params:, **)
      options[:opponent] = User.find_by(id: params[:opponent_id])
    end

    def debt1!(options, current_user:, opponent:, **)
      options[:debt1] = Debt.find_by(creditor: current_user, borrower: opponent)
    end

    def debt2!(options, current_user:, opponent:, **)
      options[:debt2] = Debt.find_by(creditor: opponent, borrower: current_user)
    end

    def update_debt1(options, **)
      options[:debt1].update(is_compensation: true)
    end

    def consent?(options, **)
      options[:debt2].is_compensation
    end

    def compensate(options, **)
      options[:compensation] = [options[:debt1].value, options[:debt2].value].min * -1
    end

    def refill_debts(options, compensation:, **)
      [options[:debt1], options[:debt2]].each.with_index(1) do |debt, index|
        operation = ::Refill::Operation::Create.call(debt: debt, params: { is_compensation: false, value: compensation })
        options["refill#{index}".to_sym] = operation[:refill]
      end
    end
  end
end