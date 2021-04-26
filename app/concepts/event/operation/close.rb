module Event::Operation
  class Close < Trailblazer::Operation
    attr_reader :major_bank, :user_events, :majors, :minors, :required_payment

    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :close?)
    step Contract::Build(constant: Event::Contract::Close, builder: :default_contract!)
    step :prepopulate!
    step Contract::Validate()
    step Contract::Persist()
    step Wrap(Shared::Macro::Transaction) {
      step :required_payment!
      step :user_events!
      step :majors!
      step :minors!
      step :create_debts!

      fail Shared::Macro::Rollback
    }

    def prepopulate!(options, **)
      options[:'contract.default'].prepopulate!(status: :close)
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, event: model)
    end

    def required_payment!(options, model:, **)
      @required_payment = model.required_payment
    end

    def user_events!(options, model:, **)
      @user_events = model.user_events.map do |user_event|
        # user_event.cost ||= required_payment
        user_event.debt = user_event.payment - required_payment
        user_event
      end
    end

    def majors!(options, model:, **)
      @majors = model.user_events.select { |user_event| user_event.debt.positive? }
      @major_bank = @majors.map(&:debt).sum
    end

    def minors!(options, model:, **)
      @minors = model.user_events.select { |user_event| user_event.debt.negative? }
    end

    def create_debts!(options, **)
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
