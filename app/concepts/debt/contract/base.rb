module Debt::Contract
  class Base < Reform::Form
    property :creditor
    property :borrower
    property :value
    property :is_compensation

    validation contract: ::Debt::Validation::Base.new
  end
end