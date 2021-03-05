module UserEvent::Validation
  class Update < Shared::ApplicationContract
    config.messages.namespace = :user_event

    params do
      required(:id).filled(:integer)
      required(:user_id).filled(:integer)
      required(:event_id).filled(:integer)
      required(:payment).filled(type?: Money)
      required(:debt).filled(type?: Money)
    end

    rule(:event_id) do
      event = Event.find_by(id: value)
      key(:event).failure(:close) if event&.close?
    end
  end
end
