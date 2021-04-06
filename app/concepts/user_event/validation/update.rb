module UserEvent::Validation
  class Update < Shared::Contract::Base
    config.messages.namespace = :user_event

    params do
      required(:id).filled(:integer)
      required(:user_id).filled(:integer)
      required(:event_id).filled(:integer)
      optional(:payment).filled(type?: Money)
      optional(:cost).filled(type?: Money)
      required(:user_event).filled(type?: UserEvent)
    end

    rule :payment do
      # TODO extra parameters are loaded
      key(:payment).failure(:invalid) if value.negative?
      # key(:payment).failure(:invalid) if value.negative? || value.zero?
    end

    rule :cost do
      key(:cost).failure(:invalid) if value.negative?
    end

    rule(:event_id) do
      event = Event.find_by(id: value)
      key(:event).failure(:close) if event&.close?
    end
  end
end
