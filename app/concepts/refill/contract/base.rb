module Refill::Contract
  class Base < Reform::Form
    property :id
    property :debt_id
    property :value, populator: :value!

    def value!(fragment:, **)
      self.value = fragment.is_a?(Money) ? fragment : Money.new(fragment * 100, 'RUB')
    end

    validation contract: ::Refill::Validation::Base.new
  end
end