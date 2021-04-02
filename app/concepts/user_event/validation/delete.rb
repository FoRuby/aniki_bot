module UserEvent::Validation
  class Delete < Shared::Contract::Base
    config.messages.namespace = :user_event

    params do
      required(:id).filled(:integer)
      required(:user_id).filled(:integer)
      required(:event_id).filled(:integer)
    end

    rule :event_id do
      event = Event.find_by(id: value)
      key(:event).failure(:close) if event&.close?
    end
  end
end
