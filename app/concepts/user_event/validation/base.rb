module UserEvent::Validation
  class Base < Shared::Contract::DryValidationBase
    config.messages.namespace = :user_event

    params do
      required(:user_id).filled(:integer)
      required(:payment).filled(type?: Money)
    end

    rule :payment do
      key(:payment).failure(:invalid) if value != Money.new(0, 'RUB')
    end
  end
end
