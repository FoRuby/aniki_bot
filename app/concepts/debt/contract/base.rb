module Debt::Contract
  class Base < Reform::Form
    property :creditor
    property :borrower
    property :coefficient, default: 1, virtual: true
    property :debt, populator: :debt!

    def debt!(fragment:, **)
      self.debt += Money.new(fragment.abs * coefficient, 'RUB')
    end

    validation contract: ::Debt::Validation::Base.new
  end
end