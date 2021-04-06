module Event::Validation
  class Close < Shared::Contract::Base
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
      required(:status).filled(:symbol)
      required(:event).filled(type?: Event)
    end

    rule :event do
      key(:event).failure(:close) if value.status.close?
      key(:event).failure(:invalid_cost) if value.user_events.sum(&:cost) > value.user_events.sum(&:payment)
    end
  end
end
