module Debt::Contract
  class UpdateFromRefill < Reform::Form
    property :debt, populator: -> (fragment:, **) { self.debt -= fragment }

    validation contract: ::Debt::Validation::UpdateFromRefill.new
  end
end