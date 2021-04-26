module Debt::Contract
  class Create < Debt::Contract::Base
    property :value, populator: :value!

    def value!(fragment:, **)
      self.value = Money.new(0, 'RUB')
    end
  end
end