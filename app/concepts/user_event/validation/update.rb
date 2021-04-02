module UserEvent::Validation
  class Update < Shared::ApplicationContract
    config.messages.namespace = :user_event

    params do
      required(:id).filled(:integer)
      required(:user_id).filled(:integer)
      required(:event_id).filled(:integer)
      required(:payment).filled(type?: Money)
      required(:debt).filled(type?: Money)
      required(:user_event).filled(type?: UserEvent)
    end

    rule :payment, :user_event do
      key(:payment).failure(:invalid) if values[:payment].negative?
      key(:payment).failure(:invalid) if values[:user_event].payment == values[:payment]
    end

    rule(:event_id) do
      event = Event.find_by(id: value)
      key(:event).failure(:close) if event&.close?
    end
  end
end
