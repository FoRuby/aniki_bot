module Event::Validation
  class Edit < Shared::ApplicationContract
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
    end

    rule :id do
      event = Event.find_by(id: value)
      key(:event).failure(:close) if event&.close?
    end
  end
end
