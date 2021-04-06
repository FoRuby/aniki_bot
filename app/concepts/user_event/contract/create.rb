module UserEvent::Contract
  class Create < Reform::Form
    property :user_id
    property :event_id
    property :payment
    property :debt

    validation contract: ::UserEvent::Validation::Create.new
  end
end