module UserEvent::Contract
  class Update < Reform::Form
    property :id
    property :user_id
    property :event_id
    property :payment, populator: :payment!
    # property :cost, populator: :cost!
    property :debt
    property :user_event, virtual: true

    def payment!(fragment:, **)
      self.payment += fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    # def cost!(fragment:, **)
    #   self.cost = fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    # end

    validation contract: ::UserEvent::Validation::Update.new
  end
end