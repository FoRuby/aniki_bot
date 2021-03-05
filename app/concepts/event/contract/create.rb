module Event::Contract
  class Create < Event::Contract::Base
    collection :user_events, form: UserEvent::Contract::Base,
                                   prepopulator: :user_events_prepopulator

    def user_events_prepopulator(options)
      user_events << UserEvent.new(options)
    end

    validation contract: ::Event::Validation::Base.new
  end
end