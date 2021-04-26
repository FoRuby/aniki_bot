module UserEvent::Contract
  class Base < Reform::Form
    property :user_id
    property :event_id
    property :payment
    property :debt, virtual: true

    validation contract: ::UserEvent::Validation::Base.new
  end
end