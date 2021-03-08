module UserEvent::Contract
  class Update < Reform::Form
    property :id
    property :user_id
    property :event_id
    property :payment, populator: :payment!
    property :debt
    property :admin, default: false
    property :user_event, virtual: true

    def payment!(fragment:, **)
      self.payment += fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    validation contract: ::UserEvent::Validation::Update.new
  end
end