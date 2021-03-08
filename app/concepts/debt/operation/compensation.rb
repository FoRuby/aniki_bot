module Debt::Operation
  class Compensation < Trailblazer::Operation
    step :debt1
    step :debt2
    step :opponent
    step :update_debt1
    step :consent?
    step :compensate
    step :refill_debts
    step :close_compensation

    def debt1(options, current_user:, params:, **)
      options[:debt1] = Debt.find_by(creditor_id: current_user.id, borrower_id: params[:opponent_id])
    end

    def debt2(options, current_user:, params:, **)
      options[:debt2] = Debt.find_by(creditor_id: params[:opponent_id], borrower_id: current_user.id)
    end

    def opponent(options, params:, **)
      options[:opponent] = User.find_by(id: params[:opponent_id])
    end

    def update_debt1(options, **)
      options[:debt1].update(is_compensation: true)
    end

    def consent?(options, **)
      options[:debt2].is_compensation
    end

    def compensate(options, current_user:, **)
      options[:compensation] = [options[:debt1].value, options[:debt2].value].min
    end

    def refill_debts(options, params:, current_user:, **)
      true if options[:compensation] == Money.new(0, 'RUB')

      Debt::Operation::Refill.call(
        current_user: current_user, debt: options[:debt1], params: { value: options[:compensation] }
      )
      Debt::Operation::Refill.call(
        current_user: current_user, debt: options[:debt2], params: { value: options[:compensation] }
      )
    end

    def close_compensation(options, current_user:, **)
      [options[:debt1], options[:debt2]].each { |debt| debt.update(is_compensation: false) }
    end
  end
end