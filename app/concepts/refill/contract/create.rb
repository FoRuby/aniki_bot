module Refill::Contract
  class Create < Reform::Form
    property :value, populator: :value!
    property :debt_id

    def value!(fragment:, **)
      self.value = fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    validation contract: ::Refill::Validation::Create.new
  end
end