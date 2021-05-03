module UserEvent::Validation
  class Create < Shared::Contract::DryValidationBase
    config.messages.namespace = :user_event
    option :record, default: UserEvent.method(:new)

    params do
      required(:user_id).filled(:integer)
      required(:event_id).filled(:integer)
      required(:payment).filled(type?: Money)
    end

    rule(:user_id).validate(is_record?: User)
    rule(:event_id).validate(is_record?: Event)

    rule(:event_id) { key(:event).failure(:close) if Event.find_by(id: value)&.close? }

    rule(:user_id, :event_id) do
      unless rule_error? :event
        user_events = UserEvent.where(user_id: values[:user_id], event_id: values[:event_id])
        key(:user).failure(:exist) if user_events.exists?
      end
    end
  end
end
