module Debt::Contract
  class Update < Reform::Form
    property :value, populator: :value!
    property :is_compensation
    property :debt, virtual: true

    def value!(fragment:, **)
      self.value += fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    validation contract: ::Debt::Validation::Update.new
  end
end