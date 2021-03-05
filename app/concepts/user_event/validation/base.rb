module UserEvent::Validation
  class Base < Shared::ApplicationContract
    config.messages.namespace = :user_event

    params do
      required(:user_id).filled(:integer)
      required(:payment).filled(type?: Money)
      required(:debt).filled(type?: Money)
    end
  end
end
