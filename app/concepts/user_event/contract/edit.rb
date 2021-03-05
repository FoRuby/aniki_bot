module UserEvent::Contract
  class Edit < Reform::Form
    property :id
    property :user_id
    property :event_id

    validation contract: ::UserEvent::Validation::Edit.new
  end
end