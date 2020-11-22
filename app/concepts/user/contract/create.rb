module User::Contract
  class Create < Reform::Form
    property :first_name
    property :last_name
    property :username
    property :chat_id

    validation contract: ::User::Validation::Create.new
  end
end