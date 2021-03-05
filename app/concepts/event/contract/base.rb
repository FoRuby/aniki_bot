module Event::Contract
  class Base < Reform::Form
    property :name
    property :date
    property :status, default: :open

    validation contract: ::Event::Validation::Base.new
  end
end