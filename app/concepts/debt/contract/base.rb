module Debt::Contract
  class Base < Reform::Form
    property :creditor
    property :borrower
    property :coefficient, default: 1, virtual: true
    property :value, populator: :value!

    def value!(fragment:, **)
      self.value += Money.new(fragment.abs * coefficient, 'RUB')
    end

    validation contract: ::Debt::Validation::Base.new
  end
end