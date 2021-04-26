module Event::Contract
  class Create < Event::Contract::Base
    collection :user_events, form: UserEvent::Contract::Base, prepopulator: :user_events!

    def user_events!(options)
      options[:user_events].each { |user_event_params| user_events << UserEvent.new(user_event_params) }
    end

    validation contract: ::Event::Validation::Create.new, default: true
  end
end