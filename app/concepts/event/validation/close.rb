module Event::Validation
  class Close < Shared::ApplicationContract
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
      required(:status).filled(:string)
    end

    rule :status do
      key(:event).failure(:close) if value.close?
    end
  end
end
