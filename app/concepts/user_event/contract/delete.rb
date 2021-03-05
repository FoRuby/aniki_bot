module UserEvent::Contract
  class Delete < Reform::Form
    property :id
    property :user_id
    property :event_id

    validation contract: ::UserEvent::Validation::Delete.new
  end
end