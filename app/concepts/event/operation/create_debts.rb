module Event::Operation
  class CreateDebts < Trailblazer::Operation
    step Wrap(Shared::Macro::Transaction) {
      step :required_payment!
      step :user_events!
      step :majors!
      step :minors!
      step :create_debts!

      fail Shared::Macro::Rollback
    }

    def required_payment!(options, model:, **)
      options[:required_payment] = model.required_payment
    end

    def user_events!(options, model:, required_payment:, **)
      options[:user_events] = model.user_events.map do |user_event|
        # user_event.cost ||= required_payment
        user_event.debt = user_event.payment - required_payment
        user_event
      end
    end

    def majors!(options, user_events:, **)
      options[:majors] = user_events.select { |user_event| user_event.debt.positive? }
      options[:major_bank] = options[:majors].map(&:debt).sum
    end

    def minors!(options, user_events:, **)
      options[:minors] = user_events.select { |user_event| user_event.debt.negative? }
    end

    def create_debts!(options, majors:, minors:, major_bank:, **)
      result = majors.each_with_object({ refills: [], debts: [] }) do |major, hash|
        minors.each do |minor|
          params = { creditor: major.user, borrower: minor.user, value: (minor.debt * (major.debt / major_bank)).abs }
          operation = Debt::Operation::Create.call(params: params)
          hash[:refills] << operation[:refill]
          hash[:debts] << operation[:debt]
        end
      end
      result.each { |key, value| options[key] = value }
    end
  end
end
