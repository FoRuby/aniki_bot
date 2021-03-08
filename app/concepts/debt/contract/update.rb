module Debt::Contract
  class Update < Reform::Form
    property :value, populator: :value!
    property :debt, virtual: true
    collection :refills, form: Refill::Contract::Create, prepopulator: :refill_prepopulator

    def value!(fragment:, **)
      self.value -= fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    def refill_prepopulator(options)
      refills << Refill.new(options)
    end

    validation contract: ::Debt::Validation::Update.new
  end
end