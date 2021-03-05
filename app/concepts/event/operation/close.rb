module Event::Operation
  class Close < Trailblazer::Operation
    attr_reader :event_bank, :user_events

    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :close?)
    step Contract::Build(constant: Event::Contract::Close)
    step Contract::Validate()
    step :update_event_status
    step :distribute_debts
    step :create_debts

    def update_event_status(options, model:, **)
      model.update(status: :close)
    end

    def distribute_debts(options, model:, **)
      @user_events = model.user_events.includes(:user)
      required_payment ||= user_events.map(&:payment).sum / user_events.count
      user_events.each { |i| i.update(debt: i.payment - required_payment) }
    end

    def create_debts(options, **)
      options[:debts] = []
      major_bank ||= user_events.majors.map(&:debt).sum
      user_events.majors.each do |user_event_major|
        user_events.minors.each do |user_event_minor|
          options[:debts] << Debt::Operation::Create.call(
            params: {
              creditor: user_event_major.user,
              borrower: user_event_minor.user,
              coefficient: user_event_major.debt / major_bank,
              debt: user_event_minor.debt
            }
          )[:model]
        end
      end
    end
  end
end
